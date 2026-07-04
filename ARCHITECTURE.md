# Workspace Architecture

## Design Principles

1. **Convention over Configuration** — consistent patterns reduce cognitive load.
2. **Layered Context** — global → technology → project → task specificity.
3. **Composable Rules** — partials are composed, never duplicated.
4. **Self-Documenting** — every folder has a descriptive `AGENTS.md` or `README.md`.
5. **Tool-Agnostic** — works with any AI coding assistant (OpenCode, Claude Code, Cursor, etc.).
6. **Extensible** — designed to support multiple technologies (currently: Accelerator SAP + Vue.js).
7. **Scale Horizontally** — add projects as folders; no central registry needed beyond index.

## Five-Layer Architecture

```
Layer 1: Global (workspace root)
├── rules/global/        → Apply to every project, every task
├── prompts/global/      → Any-tech prompts
├── config/shared/       → All-tech configs (.editorconfig, .gitattributes)
└── scripts/shared/      → Cross-cutting automations

Layer 2: Project Routing (projects/<project-name>/AGENTS.md)
├── El proyecto declara su tecnología aquí
└── "Technology: accelerator-sap-vue" → carga rules/accelerator-sap-vue/
└── También puede apuntar a un project base (ej: deprati_base)

Layer 3: Technology (rules/<tech>/, prompts/<tech>/, config/<tech>/)
├── rules/<tech>/        → Tech-specific AI rules
├── prompts/<tech>/      → Tech-specific reusable prompts
├── config/<tech>/       → Tech-specific tool configs
├── templates/<tech>/    → Skaffold templates for new projects

Layer 4: Project (projects/<project-name>/)
├── AGENTS.md            → Project description, goals, architecture (ya leído en Layer 2)
├── rules/               → Project-specific rule overrides
├── prompts/             → Project-specific prompts
└── specs/               → Project specifications

Layer 5: Sprint/Iteration (projects/<project-name>/sprints/)
├── sprint-<n>/          → Sprint goals, task list, retro
├── backlog/             → Refined backlog items
└── current/             → Active sprint context

Layer 6: Task (within code)
├── .spec.md             → Task specification
├── implementation.md    → Implementation plan
└── notes.md             → Working notes
```

## Inheritance Model

Rules and prompts use a **stack-based inheritance**:

```
Global Rules (always loaded)
  └── Project AGENTS.md (declares technology → dispatches to tech rules)
       └── Technology Rules (loaded based on what the project declared)
            └── Project Base Rules (loaded if exists, e.g., deprati_base)
                 └── Task Context (passed via instructions)
```

Higher layers can **refine but not override** mandatory rules from lower layers.

The project's `AGENTS.md` acts as the **router**: it declares the technology stack, and the agent then loads the corresponding `rules/<tech>/AGENTS.md`.

## Symlink Strategy

External projects reference the workspace via:

- **Option A**: Place project inside `projects/<name>/`
- **Option B**: Set `OPENCODE_WORKSPACE` env var pointing here
- **Option C**: `projects/<name>` → symlink to external location

## Tech Stack Registry

```
accelerator-sap-vue  → Vue 3 + CAP + SAP BTP, SAP Fiori
```

To add: modify `docs/references/technologies.md` and create corresponding folders.
