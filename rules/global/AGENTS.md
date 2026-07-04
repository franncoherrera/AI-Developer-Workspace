# Global AI Agent Rules

Apply these rules unless overridden by technology or project-specific rules.

## Communication

- Be concise: prefer 1-3 sentences when possible.
- Include file paths with line numbers when referencing code.
- Use code blocks for commands, configs, and code snippets.
- When asked about capabilities, check docs before inventing answers.

## Workflow

- **Read → Plan → Execute → Verify** — always follow this sequence.
- Before writing code, read existing files to understand conventions.
- After writing code, run linter and tests.
- If tests fail, fix the issue — do not move on.

## Git Hygiene

- Commit messages: `type(scope): description` (e.g., `feat(auth): add login endpoint`)
- Allowed types: `feat`, `fix`, `refactor`, `test`, `docs`, `chore`, `perf`, `style`
- Keep commits atomic: one logical change per commit.
- Never amend pushed commits.
- Never force push without explicit permission.

## Project Context

- Load `projects/<name>/AGENTS.md` **first** — the project declares its technology here.
- Based on the declared technology, load `rules/<technology>/AGENTS.md`.
- If the project references a base project (e.g., `deprati_base`), load that too.
- Check `prompts/<category>/` for reusable instructions when task matches.

## Error Handling

- When stuck, state what you tried and what failed.
- Suggest alternatives rather than saying "cannot do this."
- If a tool fails, retry once. If it fails again, use a different approach.
