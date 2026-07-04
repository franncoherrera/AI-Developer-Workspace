# Mandatory Rules — Non-Negotiable

These rules apply to EVERY task. Violations must be flagged immediately.

## Security

1. **Never log secrets** — no API keys, tokens, passwords in console, files, or commits.
2. **Never commit secrets** — `.env`, `.env.local`, `secrets/` are gitignored.
3. **Validate all inputs** — SQL injection, XSS, command injection are unacceptable.
4. **Prefer parameterized queries** — no string interpolation in SQL/NoSQL queries.

## Code Quality

1. **Write tests** — every new feature includes tests (unit + integration where applicable).
2. **Run linting** — always run linter before completing a task.
3. **Follow language idioms** — don't write Java like C# or TypeScript like Java.
4. **Keep functions small** — one responsibility per function. Extract when > 20 lines.
5. **No commented-out code** — delete dead code, don't comment it out.

## AI Behavior

1. **Ask before destructive actions** — delete, drop, reset, force-push require confirmation.
2. **Read before editing** — always read file contents before making changes.
3. **Explain non-trivial commands** — when running shell commands, briefly explain what and why.
4. **Respect .gitignore** — do not read or write ignored files.
5. **Stay on task** — do not refactor unrelated code while working on a feature.
