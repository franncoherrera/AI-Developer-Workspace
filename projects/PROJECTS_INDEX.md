# Project Catalog

## Active Projects

| Project | Technology | Status | Description |
|---------|-----------|--------|-------------|
| `sandbox` | _template_ | Sandbox | Testing and experimentation |

## Add a Project

1. Run: `scripts/project/new-project.ps1 -Name "<name>" -Type <tech>`
2. Or create `projects/<name>/` manually (copy `projects/_template/`)
3. Fill in `AGENTS.md` with project context
4. Add entry to this table
5. Commit: `chore(workspace): register project <name>`
