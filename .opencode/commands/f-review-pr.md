---description: Revisa un Pull Request (uso: /f-review-pr <project> <pr-number>)---
@prompts/global/partial-pr-review.md

!`cat "projects/$1/prompts/partial-pr-review.md" 2>/dev/null || echo "⚠️  No project-specific prompt found for '$1'. Using global guide only."`

First, determine the project directory for **$1**:
- Read `projects/$1/.opencode/settings.json` and look for `env_var.code` to get the environment variable name (e.g. `DEPRATI_PROJECT_PATH`)
- Resolve that environment variable to get the real project path
- If `env_var.code` is missing or the variable is not set, use `projects/$1/` as the directory

Then work FROM THAT DIRECTORY (`cd` into it) and review **PR #$2**:
1. Fetch the PR details: `gh pr view $2`
2. Fetch the PR diff: `gh pr diff $2`
3. Review the changes following the guide above
4. Check if the PR has CI checks passing: `gh pr checks $2`
