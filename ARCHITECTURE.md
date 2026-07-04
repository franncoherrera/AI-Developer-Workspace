# Workspace Architecture

## Design Principles

1. **Convention over Configuration** — consistent patterns reduce cognitive load.
2. **Layered Context** — global → technology → project → task specificity.
3. **Composable Rules** — partials are composed, never duplicated.
4. **Self-Documenting** — every folder has a descriptive `AGENTS.md` or `README.md`.
5. **Tool-Agnostic** — works with any AI coding assistant (OpenCode, Claude Code, Cursor, etc.).
6. **Polyglot by Design** — first-class support for Angular, Spring Boot, Node.js, Ruby on Rails.
7. **Scale Horizontally** — add projects as folders; no central registry needed beyond index.

## Five-Layer Architecture

```
Layer 1: Global (workspace root)
├── rules/global/        → Apply to every project, every task
├── prompts/global/      → Any-tech prompts
├── config/shared/       → All-tech configs (.editorconfig, .gitattributes)
└── scripts/shared/      → Cross-cutting automations

Layer 2: Technology (rules/<tech>/, prompts/<tech>/, config/<tech>/)
├── rules/<tech>/        → Tech-specific AI rules
├── prompts/<tech>/      → Tech-specific reusable prompts
├── config/<tech>/       → Tech-specific tool configs
├── templates/<tech>/    → Skaffold templates for new projects

Layer 3: Project (projects/<project-name>/)
├── AGENTS.md            → Project description, goals, architecture
├── rules/               → Project-specific rule overrides
├── prompts/             → Project-specific prompts
└── specs/               → Project specifications

Layer 4: Sprint/Iteration (projects/<project-name>/sprints/)
├── sprint-<n>/          → Sprint goals, task list, retro
├── backlog/             → Refined backlog items
└── current/             → Active sprint context

Layer 5: Task (within code)
├── .spec.md             → Task specification
├── implementation.md    → Implementation plan
└── notes.md             → Working notes
```

## Inheritance Model

Rules and prompts use a **stack-based inheritance**:

```
Global Rules (always loaded)
  └── Technology Rules (loaded if tech detected)
       └── Project Rules (loaded if available)
            └── Task Context (passed via instructions)
```

Higher layers can **refine but not override** mandatory rules from lower layers.

## Symlink Strategy

External projects reference the workspace via:

- **Option A**: Place project inside `projects/<name>/`
- **Option B**: Set `OPENCODE_WORKSPACE` env var pointing here
- **Option C**: `projects/<name>` → symlink to external location

## Tech Stack Registry

```
angular        → TypeScript, Angular CLI, NgRx, RxJS
```

More technologies will be added in future phases.

To add: modify `docs/references/technologies.md` and create corresponding folders.
