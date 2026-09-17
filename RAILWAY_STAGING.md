# Railway Staging Runbook

Issue 36 uses a deliberately small staging topology: one backend service, one
Railway PostgreSQL service, and one persistent uploads volume. Keep all three in
Railway's Singapore region. The volume-backed upload design requires exactly one
backend replica.

The provisioned staging API domain is
`https://backend-staging-1c25.up.railway.app`. The service follows `dev`; a merge
to that branch starts an automatic deployment.

## One-time setup

1. Create a Railway project and a `staging` environment.
2. Add Railway PostgreSQL and name the service `Postgres`. Keep its generated
   private `DATABASE_URL`; do not add a public TCP URL to the backend.
3. Add a GitHub service from `ktul15/uber_eats_clone` with these settings:
   - Service name: `backend`
   - Source branch: `dev`
   - Root directory: `/backend`
   - Region: Singapore
   - Replicas: `1`
   - Build command: `npm run build`
   - Pre-deploy command: `npm run migrate:deploy`
   - Start command: `npm start`
   - Health-check path: `/health`
   - Restart policy: `On Failure`, maximum retries: `3`
4. Generate a Railway HTTPS domain for the backend service.
5. Attach a volume named `uploads` to the backend at `/data/uploads`. Do not
   scale the service above one replica while this volume is the upload store.
6. In the PostgreSQL service's **Backups** tab, enable daily scheduled backups
   when the workspace plan supports them (see **Current account limitations**).

Railway variables can reference another service or a Railway-provided value.
The staging backend currently stores `DATABASE_URL` as a sealed service-local
value because Railway pre-deploy containers repeatedly received stale
authentication through the cross-service reference. Copy the current sealed
`Postgres.DATABASE_URL` value without exposing it, and update both services
together whenever the database password is rotated. Use references for the
remaining Railway-provided values:

```dotenv
APP_ENV=staging
NODE_ENV=production
DATABASE_URL=<current sealed Postgres.DATABASE_URL>
JWT_SECRET=<at-least-32-random-bytes>
BASE_URL=https://${{RAILWAY_PUBLIC_DOMAIN}}
ALLOWED_ORIGINS=https://<each-approved-web-origin-comma-separated>
STRIPE_SECRET_KEY=sk_test_<staging-key>
UPLOAD_DIR=/data/uploads
DATABASE_POOL_MAX=10
DATABASE_CONNECTION_TIMEOUT_MS=5000
DATABASE_IDLE_TIMEOUT_MS=30000
TRUST_PROXY_HOPS=1
RAILWAY_DEPLOYMENT_DRAINING_SECONDS=30
```

Because the database URL is duplicated, rotate it as one maintenance operation:

1. Pause backend traffic and retain the previous sealed values until validation
   completes. Generate a URL-safe random password (for example, 32 random bytes
   encoded as hexadecimal); never place it in the repository or issue comments.
2. Use `railway ssh -s Postgres -e staging` and local peer-authenticated `psql`
   to change the actual `postgres` role password. Updating Railway variables
   alone does not change the password stored by PostgreSQL.
3. Update the Postgres service's sealed `PGPASSWORD` and `DATABASE_URL`, then
   replace the backend service's sealed `DATABASE_URL` with that same URL. Keep
   the username, private hostname, port, and database name unchanged.
4. Start a new backend source deployment. Confirm `prisma migrate deploy`
   succeeds, the deployment becomes healthy, and `/health` returns HTTP 200.
5. If validation fails, restore the previous role password and all three sealed
   variables before redeploying. Resume traffic only after the old or new set is
   consistent end-to-end.

Native iOS and Android calls, including Socket.IO connections, are accepted
without an `Origin` header. Browser and Flutter Web origins must be listed
exactly in `ALLOWED_ORIGINS`; never use `*` with credentials.

The current checkout flow creates and verifies PaymentIntents synchronously and
does not expose a Stripe webhook endpoint. Do not create an event destination or
set a webhook signing secret until a verified webhook handler is implemented.

Firebase remains optional in staging. To enable FCM, also set and seal
`FIREBASE_PROJECT_ID`, `FIREBASE_CLIENT_EMAIL`, and `FIREBASE_PRIVATE_KEY`.
Without the complete set, startup emits a structured `firebase.disabled`
warning and the rest of the API continues to run.

References:

- [Railway variables and references](https://docs.railway.com/variables)
- [Railway-provided deployment variables](https://docs.railway.com/variables/reference)
- [Railway PostgreSQL backup and restore guide](https://docs.railway.com/guides/postgres-backups-restores)

## Deploy and verify

Merges to `dev` deploy automatically. Before promoting a deployment, verify the
pre-deploy migration succeeded and `/health` returns HTTP 200 with the standard
success envelope. A database connection failure intentionally returns HTTP 503.

Build all Flutter staging clients with the same HTTPS endpoint for REST and
Socket.IO:

```bash
flutter run --dart-define=API_BASE_URL=https://backend-staging-1c25.up.railway.app
```

Run this staging smoke suite after the first deploy and after infrastructure
changes:

1. Register and log in as customer, owner, and driver.
2. Create a restaurant and menu item, upload its image, and fetch the image URL.
3. Redeploy the backend and confirm that the same image URL still returns the
   image, proving the `/data/uploads` volume is mounted.
4. Add the item to a cart, create a Stripe test payment, and place the order.
5. Accept and progress the order through restaurant and driver states to
   delivery, including a Socket.IO disconnect/reconnect during the delivery.
6. Confirm each request log has a request ID, method, path, status, duration,
   replica ID, and region, with no request body or authorization value.
7. Inspect the service **Observability** view for CPU, memory, network, volume,
   restart, and HTTP health-check behavior.

## Backup and restore drill

Railway volume backups cover routine in-project recovery. A logical dump proves
portable recovery. Railway private hostnames only resolve inside the project
network, so use Railway's SSH transport rather than exposing a permanent TCP
proxy. The following workflow was exercised against staging. It restores into a
temporary empty database and never writes to the primary `railway` database.

In terminal A, create an isolated SSH config and keep the tunnel open:

```bash
export RAILWAY_SSH_CONFIG=/tmp/uber-eats-railway-ssh-config
npx -y @railway/cli ssh config -s Postgres -e staging \
  --path "$RAILWAY_SSH_CONFIG" --alias uber-eats-staging-postgres
ssh -F "$RAILWAY_SSH_CONFIG" -N \
  -L 15433:127.0.0.1:5432 uber-eats-staging-postgres
```

In terminal B, copy `PGPASSWORD` from the PostgreSQL service's sealed Railway
variables when prompted. `read -s` keeps it out of shell history and output:

```bash
read -rs PGPASSWORD && export PGPASSWORD
export PGHOST=127.0.0.1 PGPORT=15433 PGUSER=postgres
pg_dump --format=custom --no-owner --no-acl --dbname=railway --file=staging.dump
createdb issue36_restore_drill
pg_restore --exit-on-error --no-owner --no-acl --dbname=issue36_restore_drill staging.dump
psql --dbname=issue36_restore_drill -c 'SELECT COUNT(*) FROM "User";'
dropdb issue36_restore_drill
unset PGPASSWORD PGHOST PGPORT PGUSER
rm staging.dump
```

Stop the terminal-A tunnel with Ctrl-C, then run
`rm "$RAILWAY_SSH_CONFIG" && unset RAILWAY_SSH_CONFIG` there. Record the backup
timestamp, commands, row-count checks, and temporary database name in the issue.
If the drill uses a separate temporary PostgreSQL service instead, open a
second SSH tunnel on a different local port and delete the service after
verification.

For a Railway volume-backup restore, use the PostgreSQL service's **Backups**
tab, select the snapshot, stage the restore, review the new volume, and deploy
it.

## Rollback and diagnosis

- Application rollback: open the backend service's **Deployments** tab, select
  the last known-good deployment, and choose **Redeploy**. Review whether a
  forward database fix is required; never rewrite or delete an applied Prisma
  migration.
- Database rollback: prefer a forward migration. For destructive or accidental
  data changes, restore a scheduled volume backup or the verified logical dump.
- Logs: filter structured output by `event`, `requestId`,
  `RAILWAY_DEPLOYMENT_ID`, or `RAILWAY_REPLICA_ID`.
- Metrics: inspect Railway's Observability charts before changing resource
  limits. Correlate spikes with request logs and deploy IDs.

## Scaling triggers

Keep the staging design simple until measurements justify added infrastructure:

- Add PgBouncer when connection saturation or concurrent deploy overlap makes
  the PostgreSQL connection budget the bottleneck; reduce each app pool before
  adding replicas.
- Add Redis and a Socket.IO Redis adapter only when multiple backend replicas
  are required. Railway currently does not provide sticky sessions.
- Move uploads to object storage before adding another replica, another region,
  or independent background workers.
- Add replicas only after uploads are stateless and Socket.IO has a shared
  adapter, and only when sustained CPU, memory, latency, or availability targets
  show that vertical sizing and query tuning are insufficient.

## Dependency audit baseline

`npm audit fix` was run without `--force`, updating compatible locked transitive
packages. `npm audit --omit=dev` still reports six upstream advisories: four high
findings through Prisma CLI/config (`deepmerge-ts` and `mysql2`) and two moderate
findings through Firebase's `gaxios`/`uuid` chain. npm's suggested full fix
downgrades Prisma 7 to Prisma 6, so it is intentionally not applied. Recheck the
audit when Prisma and Firebase publish compatible fixes.

## Current account limitations

Railway rejected the scheduled-backup mutation for this project's current trial
plan. The repository owner explicitly approved deferring scheduled backups for
this staging-only Issue 36 deployment on 2026-09-17; production/release work
must revisit this requirement in Issue 38. On 2026-09-17, the logical drill
successfully restored the staging dump into a disposable database and verified
8 completed migrations across 13 public tables; the temporary database and
local dump were then removed. Upgrade the workspace and enable a daily backup
schedule before storing production data.
