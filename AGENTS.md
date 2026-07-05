# AI Developer Workspace — Agent Context

You are in the **AI Developer Workspace**, a centralized environment for AI-assisted software development.

## Quick Start

- **Read this file first** → You are here.
- **Workspace rules** → `rules/` — mandatory instructions for AI behavior.
- **Project list** → `projects/PROJECTS_INDEX.md`
- **Current project** → check `/workspace` for symlink or `OPENCODE_WORKSPACE_PROJECT` env.

## Workspace Structure (Top Level)

```
.opencode/     → Agent configuration (settings, agents, skills)
rules/         → Hierarchical rules: global > technology > project
prompts/       → Reusable prompt library (composable partials)
knowledge-base/→ Personal knowledge: ADRs, patterns, learnings, cheatsheets
projects/      → Project catalog (each subfolder is a project)
config/        → Shared tool configurations (ESLint, Prettier, editorconfig)
scripts/       → Automation and utility scripts
mcp/           → MCP server definitions and tool configurations
docs/          → Technical documentation, architecture, guides
```

## Context Resolution Order

When working on a task, context is resolved in this priority:

1. `rules/global/mandatory.md` — non-negotiable rules
2. `rules/global/AGENTS.md` — global best practices
3. `projects/<project>/AGENTS.md` — **lee esto ANTES que las reglas de tecnología**. Aquí el proyecto declara su tecnología (eg: "accelerator-sap-vue") y el agente carga las reglas correspondientes.
4. `rules/<technology>/AGENTS.md` — tech-specific rules (cargadas según lo que declaró el proyecto en el paso 3)
5. `prompts/<category>/` — reusable prompts loaded as needed
6. `knowledge-base/<topic>/` — reference material

## Key Conventions

- **Folders**: `kebab-case`
- **Documents**: `PascalCase.md`
- **Reusable partials**: `partial-*.md`
- **Technology keys**: `accelerator-sap-vue`
- **Each project has**: `AGENTS.md`, `rules/`, `prompts/` (if needed)

## How to Add a New Technology

1. Create `rules/<tech>/AGENTS.md`
2. Create `prompts/<tech>/`
3. Create `config/<tech>/`
4. Register in `docs/references/technologies.md`

## How to Add a New Project

1. Create `projects/<name>/AGENTS.md` with project context
2. Add entry to `projects/PROJECTS_INDEX.md`
