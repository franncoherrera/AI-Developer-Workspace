# Workspace Architecture Overview

## High-Level Diagram

```
┌─────────────────────────────────────────────────────────────┐
│                    AI Developer Workspace                    │
├─────────────────────────────────────────────────────────────┤
│  ┌─────────┐  ┌──────────┐  ┌──────────┐  ┌─────────────┐ │
│  │  Rules   │  │  Prompts  │  │  Config   │  │    Docs     │ │
│  │ (global) │  │ (global)  │  │ (shared)  │  │ (technical) │ │
│  │ (tech)   │  │ (tech)    │  │ (tech)    │  │ (guides)    │ │
│  │ (proj)   │  │ (domain)  │  │ (ide)     │  │ (decisions) │ │
│  └─────────┘  └──────────┘  └──────────┘  └─────────────┘ │
│                                                             │
│  ┌──────────┐  ┌──────────┐  ┌───────┐  ┌───────────────┐ │
│  │Knowledge │  │Templates  │  │Specs  │  │   Workflows    │ │
│  │  Base    │  │(angular)  │  │(BDD)  │  │(CI/CD, hooks) │ │
│  │(ADRs)    │  │(spring)   │  │(Gherk)│  │(github/gitlab)│ │
│  └──────────┘  └──────────┘  └───────┘  └───────────────┘ │
│                                                             │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐  ┌────────────┐ │
│  │  Docker  │  │   MCP    │  │  Scripts  │  │  Projects  │ │
│  │services  │  │ servers  │  │automation │  │ catalog    │ │
│  └──────────┘  └──────────┘  └──────────┘  └────────────┘ │
└─────────────────────────────────────────────────────────────┘
```

## Data Flow

1. AI agent loads this workspace root
2. Reads `AGENTS.md` for immediate orientation
3. Loads `rules/global/mandatory.md` (non-negotiable)
4. Loads `rules/global/AGENTS.md` (global best practices)
5. Detects project technology → loads `rules/<tech>/AGENTS.md`
6. Detects project → loads `projects/<project>/AGENTS.md`
7. Composes prompt from `prompts/<category>/` if task matches
8. References `knowledge-base/` for architecture decisions and patterns
