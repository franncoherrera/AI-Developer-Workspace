# AI Developer Workspace

**Un entorno centralizado para desarrollo asistido por inteligencia artificial.**

---

## Cómo empezar

### Rápido (un solo comando)

```bash
./bootstrap.sh
```

Detecta automáticamente los proyectos en `projects/` y sincroniza todo para cada uno. Hace `git pull`, `npm install`, setup inicial, carga `.env`, sincroniza MCP servers + comandos + knowledge-base de todos los proyectos, y valida.

### Paso a paso

```bash
# 1. Clonar
git clone <repo-url> ai-developer-workspace
cd ai-developer-workspace

# 2. Setup inicial
./scripts/shared/setup-workspace.sh

# 3. Crear .env con las rutas de tu proyecto (ej: Deprati)
#    Usá las variables que necesites según tu proyecto
cat > .env << EOF
export ${projectName}_PROJECT_PATH=/ruta/al/codigo
export ${projectName}_BASE_PROJECT_PATH=/ruta/a/specs
EOF

# 4. Sincronizar MCP servers, comandos y knowledge-base
./scripts/mcp/sync.sh ${projectName}
./scripts/commands/sync-commands.sh
./scripts/knowledge/sync.sh

# 5. Verificar
./scripts/utils/validate-rules.sh
```

## Flujo de trabajo diario

### 1. Abrí el workspace

```bash
opencode
```

### 2. Activá el proyecto con `/f-agent`

```
/f-agent ${projectName}
```

Esto le indica al agente en qué proyecto trabajar. Resuelve automáticamente la ruta real desde las variables de entorno.

### 3. Usá los comandos disponibles

| Comando | Para qué |
|---------|----------|
| `/f-agent ${projectName}` | Activar un proyecto |
| `/f-review-changes ${projectName}` | Revisar cambios staged antes de commitear |
| `/f-review-pr ${projectName} <pr-id>` | Revisar un Pull Request |
| `/qubik-*` | Comandos Qubik (si tu proyecto los usa) |

### 4. El agente puede usar el navegador para probar

Cuando revises cambios de UI, el agente va a levantar el proyecto y probarlo visualmente usando las herramientas `browser_*`.

### 5. Memoria persistente entre sesiones

El agente puede leer y escribir notas en `knowledge-base/`. Es su memoria a largo plazo. Solo escribe cuando se lo pedís explícitamente.

```
"guardá esta decisión en la memoria"
"buscá en la base de conocimiento cómo resolvimos X"
"revisá las ADRs del proyecto antes de empezar"
```

## MCP Servers disponibles

| Server | Para qué |
|--------|----------|
| `browser` | Probar UIs con Chrome/Edge |
| `obsidian` | Memoria persistente en `knowledge-base/` |
| `filesystem` | Acceso a archivos del workspace |
| `${projectName}-mcp` | RAG sobre documentación del proyecto (si está configurado) |

## Cómo agregar un nuevo proyecto

```bash
./scripts/project/new-project.sh ${projectName} accelerator-sap-vue
```

Si el proyecto tiene documentación externa (`$<NAME>_BASE_PROJECT_PATH`), el script crea automáticamente el symlink en `knowledge-base/_proyectos/`.

---

## ECC-Universal (Everything Claude Code)

Este workspace usa **[ecc-universal](https://github.com/affaan-m/ECC)** como plugin de productividad. Aporta 261 skills, 64 agentes, 84 comandos, hooks automáticos y reglas.

La lista completa de skills está en [`docs/ecc-skills-reference.md`](docs/ecc-skills-reference.md).

### Qué corre automáticamente (hooks)

Sin que invoques nada, ECC monitorea y acciona en segundo plano:

| Evento | Qué hace |
|--------|----------|
| **SessionStart** | Carga contexto previo, detecta package manager |
| **PreToolUse (Bash)** | Bash preflight — quality checks |
| **PreToolUse (Write/Edit)** | GateGuard (exige investigar antes de editar), sugiere `/compact`, protege configs de linter |
| **PostToolUse (Edit/Write)** | Quality gates, design quality check, alerta de `console.log` |
| **Stop** | Formatea + typecheckea archivos editados, persiste sesión, trackea costos, notificación desktop |
| **SessionEnd** | Guarda marcador de cierre de sesión |

### Skills, Agentes, Hooks y Rules — para qué sirve cada uno

| Componente | Qué es | Cómo se activa |
|------------|--------|----------------|
| **Skills** | Guías de workflow inyectadas en el contexto del agente (TDD, patrones backend/frontend, API design, security review). Le enseñan al agente *cómo* hacer cada cosa. | Se cargan automáticamente desde `node_modules/ecc-universal/skills/` según lo declarado en `opencode.jsonc`. El agente las lee sin que el usuario las invoque. |
| **Agentes especializados** | Sub-agentes con prompt enfocado y tools limitadas para una tarea específica: `planner`, `code-reviewer`, `tdd-guide`, `security-reviewer`, `build-error-resolver`, etc. | Se invocan explícitamente vía comandos (`/plan`, `/tdd`, `/code-review`) o el agente principal los delega automáticamente según la tarea. |
| **Hooks** | Scripts que se disparan ante eventos del ciclo de vida (PreToolUse, PostToolUse, Stop, etc.). Hacen control de calidad, protegen configs, trackean costos, formatean código, persisten sesión. | Corren solos, sin intervención del usuario. |
| **Rules** | Instrucciones mandatorias no negociables (no hardcodear secrets, validar inputs, no mutar objetos). Están en `rules/` y también en los `AGENTS.md` de ECC. | Se cargan como contexto permanente al inicio de la sesión. El agente las sigue siempre. |

### Qué invocás explícitamente (comandos y agentes)

| Comando | Qué hace |
|---------|----------|
| `/plan` | Planificar features complejas (usa agente planner) |
| `/tdd` | Workflow TDD (usa tdd-guide) |
| `/code-review` | Code review post-cambio (usa code-reviewer) |
| `/security` | Security review (usa security-reviewer) |
| `/build-fix` | Diagnosticar errores de build (usa build-error-resolver) |
| `/e2e` | Generar y correr tests E2E con Playwright |
| `/refactor-clean` | Limpiar dead code y consolidar duplicados |
| `/orchestrate` | Orquestar múltiples agentes |
| `/verify` | Verification loop (build → types → lint → tests → security) |
| `/eval` | Evaluar contra criterios definidos |
| `/learn` | Extraer patrones y learnings de la sesión |

> Repo oficial: [github.com/affaan-m/ECC](https://github.com/affaan-m/ECC)

## Más info

Para documentación detallada del workspace, ver `docs/guide/workspace-reference.md`.
