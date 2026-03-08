---
description: Standard Git Workflow for the Project
---
# Git Workflow

1. **Master Branch (`master` / `main`)**: Contains production-ready code.
2. **Development Branch (`dev`)**: The main integration branch for all phases.
3. **Feature Branches (`feature/issue-number-description`)**: 
   - ALWAYS branch off from `dev`.
   - Work on the specific issue here.
   - Example: `git checkout dev && git pull && git checkout -b feature/issue-2-auth`

## Steps to Follow for Every Task:
1. Identify the Issue ID you are working on.
2. Create and switch to the feature branch from `dev`:
   ```bash
   git checkout dev
   git pull origin dev
   git checkout -b feature/issue-[ID]-[brief-name]
   ```
3. Complete development and commit changes. 
   - **Crucial:** Always add `closes #[ID]` in the commit message before committing (e.g., `git commit -m "Add authentication logic, closes #2"`).
4. Merge feature branch into `dev`:
   ```bash
   git checkout dev
   git merge feature/issue-[ID]-[brief-name]
   git push origin dev
   ```
5. After a Phase is completed and tested, merge `dev` into `master`.
   ```bash
   git checkout master
   git merge dev
   git push origin master
   ```
