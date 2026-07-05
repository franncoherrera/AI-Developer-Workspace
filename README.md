# AI Developer Workspace

**Un entorno centralizado para desarrollo asistido por inteligencia artificial.**

---

## Guía de Uso desde Cero

### Día 1: Configuración

```bash
# 1. Clonar
git clone <repo-url> ai-developer-workspace
cd ai-developer-workspace

# 2. Setup inicial
./scripts/shared/setup-workspace.sh

# 3. Definir variables de entorno del proyecto (ej: Deprati)
export DEPRATI_PROJECT_PATH=/ruta/al/codigo
export DEPRATI_BASE_PROJECT_PATH=/ruta/a/specs

# 4. Sincronizar MCP servers y comandos externos
./scripts/mcp/sync.sh deprati
./scripts/commands/sync-commands.sh

# 5. Verificar
./scripts/utils/validate-rules.sh
```

### Flujo de trabajo diario

1. **Abrir el workspace** con OpenCode (o cualquier agente IA compatible)
2. **El agente carga contexto automáticamente** siguiendo: `mandatory.md` → `global/AGENTS.md` → proyecto declara tecnología → tech rules
3. **Usar comandos slash** para tareas comunes:
   - `/f-review-changes deprati` — revisar cambios staged antes de commitear
   - `/f-review-pr deprati 42` — revisar un Pull Request
4. **El agente trabaja** desde el directorio real del proyecto (resuelto vía `env_var` en `projects/<proyecto>/.opencode/settings.json`)
5. **Los cambios** se hacen en el código real (afuera del workspace), las specs y documentación en la base externa

### Estructura de un proyecto

Cada proyecto en `projects/<nombre>/` tiene:
- `AGENTS.md` — contexto, tecnología, reglas específicas
- `.opencode/settings.json` — configuración del agente, `env_var` para resolver paths externos
- `prompts/` — prompts específicos del proyecto

### Comandos disponibles

| Comando | Uso |
|---------|-----|
| `/f-review-changes <project>` | Revisa cambios staged en el proyecto |
| `/f-review-pr <project> <pr>` | Revisa un PR usando `gh` |
| `/qubik-*` | Comandos Qubik (sincronizados desde proyecto externo) |

### Reglas importantes

- **Los comandos se versionan** — están en `.opencode/commands/` (trackeados por git)
- **Los prompts globales** están en `prompts/global/`
- **Los prompts de proyecto** están en `projects/<nombre>/prompts/`
- Para documentación detallada del workspace, ver `docs/guide/workspace-reference.md`
