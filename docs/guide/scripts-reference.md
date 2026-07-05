# Scripts Reference

> Generado automáticamente por `scripts/docs/generate-scripts-ref.sh`.
> Se actualiza al commitear si hay cambios en `scripts/`.

## `scripts/commands/sync-commands.sh`

Sincroniza comandos slash (/qubik-*) desde un proyecto externo hacia .opencode/commands/. Lee DEPRATI_BASE_PROJECT_PATH del .env.

**Uso:** `./scripts/commands/sync-commands.sh`

**Dependencias:** (ninguna — solo bash y find)

**Variables de entorno:** DEPRATI_BASE_PROJECT_PATH (desde .env)

**Posibles fallas:**

- Variable no seteada → exit 0 (setup incompleto, no es error)
- Directorio origen sin .md files → exit 0
- Archivo local con mismo nombre (no symlink) → warning, se saltea

## `scripts/docs/generate-scripts-ref.sh`

Genera automáticamente docs/guide/scripts-reference.md a partir de los doc headers estandarizados en cada script .sh. Se ejecuta como pre-commit hook cuando scripts/ cambia, o manualmente cuando se desee.

**Uso:** `./scripts/docs/generate-scripts-ref.sh`

**Dependencias:** (ninguna — solo bash)

**Variables de entorno:** (ninguna)

**Posibles fallas:**

- Ningún script .sh encontrado → genera doc vacío (no es error)

## `scripts/docs/generate.sh`

Generador maestro de documentación. Escanea el estado real del workspace y actualiza las secciones marcadas con <!-- AUTO: --> en docs/guide/workspace-reference.md. También regenera scripts-reference.md.

**Uso:** `./scripts/docs/generate.sh`

**Dependencias:** jq

**Variables de entorno:** (ninguna)

**Posibles fallas:**

- workspace-reference.md no encontrado → exit 1
- technologies.json no encontrado → warning, se salta sección

## `scripts/doctor.sh`

Diagnóstico completo del workspace. Verifica variables de entorno, directorios externos, MCP servers, estructura de reglas, y dependencias.

**Uso:** `./scripts/doctor.sh [project]`

**Dependencias:** jq

**Variables de entorno:** DEPRATI_PROJECT_PATH, DEPRATI_BASE_PROJECT_PATH

**Posibles fallas:**

- jq no instalado → error fatal
- Variables no seteadas → warning, no fatal (setup incompleto)
- Directorios externos faltantes → warning
- Exit code: 0 si todo ok, 1 si hay issues

## `scripts/hooks/pre-commit.sh`

Pre-commit hook que regenera automáticamente docs/guide/scripts-reference.md cuando hay cambios en scripts/. Instalado por setup-workspace.sh como symlink en .git/hooks/pre-commit.

**Uso:** `(se ejecuta automáticamente en git commit)`

**Dependencias:** (ninguna)

**Variables de entorno:** (ninguna)

**Posibles fallas:**

- Si la generación falla, se muestra warning pero no bloquea el commit

## `scripts/knowledge/sync.sh`

Sincroniza symlinks en knowledge-base/_proyectos/ con las variables de entorno *_BASE_PROJECT_PATH. Crea enlaces a la documentación externa de cada proyecto (specs, ADRs, docs, rules).

**Uso:** `./scripts/knowledge/sync.sh`

**Dependencias:** (ninguna)

**Variables de entorno:** *_(BASE_PROJECT_PATH|PROJECT_PATH) — cada una genera un symlink

**Posibles fallas:**

- Ninguno (idempotente)

## `scripts/mcp/sync.sh`

Sincroniza definiciones de MCP servers desde un proyecto externo hacia mcp/servers/. Soporta dos formatos:   1) Archivos .json individuales en .opencode/mcp/servers/ (symlink)   2) .mcp.json en la raíz del proyecto externo (conversión automática a      formato OpenCode, con prefijo ext.)

**Uso:** `./scripts/mcp/sync.sh <project>`

**Dependencias:** jq

**Variables de entorno:** DEPRATI_BASE_PROJECT_PATH (o el env_var.base definido en settings.json)

**Posibles fallas:**

- settings.json no encontrado → exit 1
- env_var.base no definido → exit 0 (no es error, falta config)
- Variable de entorno no seteada → exit 0 (setup incompleto)
- Sin servers en origen → exit 0

## `scripts/project/new-project.sh`

Crea un nuevo proyecto a partir de un template registrado en technologies.json. Copia la estructura del template, genera AGENTS.md, y actualiza PROJECTS_INDEX.md.

**Uso:** `./scripts/project/new-project.sh <name> <type> [path]`

**Dependencias:** jq

**Variables de entorno:** (ninguna)

**Posibles fallas:**

- Sin argumentos → exit 1 con usage
- Tecnología no registrada → exit 1 con lista disponibles
- Tecnología sin template (has.template = false) → exit 1
- Template no encontrado → exit 1
- Proyecto ya existe → exit 1

## `scripts/shared/setup-workspace.sh`

Setup inicial del workspace. Verifica prerequisitos (git, docker, jq, node) y crea los directorios base necesarios.

**Uso:** `./scripts/shared/setup-workspace.sh`

**Dependencias:** git, docker, jq, node (opcional — warns si faltan)

**Variables de entorno:** (ninguna)

**Posibles fallas:**

- Ningún error fatal; los prerequisitos faltantes son warnings

## `scripts/utils/register-technology.sh`

Registra una nueva tecnología en el workspace. Crea las carpetas en rules/, prompts/, config/, templates/ y añade la entrada en technologies.json.

**Uso:** `./scripts/utils/register-technology.sh <key> <name>`

**Dependencias:** jq

**Variables de entorno:** (ninguna)

**Posibles fallas:**

- Sin argumentos → exit 1 con usage
- Tecnología ya registrada → exit 1
- technologies.json no encontrado → exit 1

## `scripts/utils/validate-rules.sh`

Valida la integridad del workspace: verifica que toda carpeta rules/ tenga su AGENTS.md, que el registro de tecnologías coincida con la estructura real, y detecta carpetas huérfanas.

**Uso:** `./scripts/utils/validate-rules.sh`

**Dependencias:** jq

**Variables de entorno:** (ninguna)

**Posibles fallas:**

- technologies.json no encontrado → exit 1
- Missing rules, prompts, config, o templates → exit 1 con lista
- Orphan folders → exit 1 con lista

