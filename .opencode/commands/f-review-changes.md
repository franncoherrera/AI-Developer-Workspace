---description: Revisa cambios staged (git add) pendientes de commit (uso: /f-review-changes <project>)---
@prompts/global/partial-stash-review.md

!`cat "projects/$1/prompts/partial-stash-review.md" 2>/dev/null || echo "⚠️  No project-specific prompt found for '$1'. Using global guide only."`

First, determine the project directory for **$1**:
- Read `projects/$1/.opencode/settings.json` and look for `env_var.code` to get the environment variable name (e.g. `DEPRATI_PROJECT_PATH`)
- Resolve that environment variable to get the real project path
- If `env_var.code` is missing or the variable is not set, use `projects/$1/` as the directory

Then work FROM THAT DIRECTORY (`cd` into it) and review the **staged changes** following the guide above.
Run `git diff --cached --stat` to list what's staged, then `git diff --cached` for the full diff.
Also review unstaged changes with `git diff` that may belong to the same commit.
