# AI Developer Workspace

**Un entorno centralizado para desarrollo asistido por inteligencia artificial.**

---

## Cómo empezar

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

Para documentación detallada del workspace, ver `docs/guide/workspace-reference.md`.
