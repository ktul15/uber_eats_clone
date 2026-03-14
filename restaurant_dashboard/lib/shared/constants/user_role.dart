enum UserRole {
  customer('CUSTOMER'),
  owner('OWNER'),
  driver('DRIVER');

  final String value;
  const UserRole(this.value);
}
