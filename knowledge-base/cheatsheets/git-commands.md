# Git Cheatsheet

## Branch Workflow
```bash
git checkout -b feat/PROJ-123-add-login       # New feature branch
git checkout -b fix/PROJ-456-fix-npe           # Bug fix branch
git checkout -b chore/update-deps              # Maintenance branch
```

## Interactive Commands (avoid in automation)
```bash
git rebase -i HEAD~3                           # Squash last 3 commits
git add -p                                     # Stage partially
```

## Safety
```bash
git reflog                                     # Recovery after mistakes
git bisect start                                # Find bug commit
```

## Commit Types
- `feat:` — new feature
- `fix:` — bug fix
- `refactor:` — code restructuring
- `docs:` — documentation
- `chore:` — build, deps, tooling
- `perf:` — performance improvement
- `style:` — formatting, linting
