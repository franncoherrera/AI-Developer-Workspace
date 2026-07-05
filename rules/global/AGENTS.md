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
- After writing code, run linter.

## Git Hygiene

- Commit messages: `type(scope): description` (e.g., `feat(auth): add login endpoint`)
- Allowed types: `feat`, `fix`, `refactor`, `docs`, `chore`, `perf`, `style`
- Keep commits atomic: one logical change per commit.
- Never amend pushed commits.
- Never force push without explicit permission.

## Project Context

- Load `projects/<name>/AGENTS.md` **first** — the project declares its technology here.
- Based on the declared technology, load `rules/<technology>/AGENTS.md`.
- If the project references a base project via env var (e.g., `$<NAME>_BASE_PROJECT_PATH`), load docs/rules from that path too.
- Check `prompts/<category>/` for reusable instructions when task matches.

## Knowledge Base (Obsidian)

- `knowledge-base/` es el vault de Obsidian — memoria persistente del workspace.
- `knowledge-base/_proyectos/` contiene symlinks a la documentación externa de cada proyecto (specs, ADRs, docs, rules).
- Usá las herramientas `obsidian_*` para buscar, leer y escribir notas markdown aquí.
- Cuando trabajes en un proyecto, revisá sus docs en `knowledge-base/_proyectos/<nombre>/` vía Obsidian.

## Browser Testing

- Tenés herramientas `browser_*` para controlar un navegador Chrome/Edge.
- usalas después de escribir o revisar código con UI: abrí el proyecto, navegá, llená formularios, tomá screenshots.
- Cuando revises cambios (staged o PR) que afecten la interfaz, **siempre** levantá el proyecto y probalo visualmente con el browser antes de aprobar.

## Error Handling

- When stuck, state what you tried and what failed.
- Suggest alternatives rather than saying "cannot do this."
- If a tool fails, retry once. If it fails again, use a different approach.
