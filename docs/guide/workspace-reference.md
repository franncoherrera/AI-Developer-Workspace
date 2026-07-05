# AI Developer Workspace — Reference

> Documentación técnica completa del workspace. Para la guía de uso diario ver `README.md`.

---

## Tabla de Contenidos

- [Filosofía y Principios de Diseño](#filosofía-y-principios-de-diseño)
- [Estructura del Workspace](#estructura-del-workspace)
- [Arquitectura en 5 Capas](#arquitectura-en-5-capas)
- [Tecnologías Soportadas](#tecnologías-soportadas)
- [Uso para Agentes IA](#uso-para-agentes-ia)
- [Reglas y Políticas](#reglas-y-políticas)
- [Prompts Reutilizables](#prompts-reutilizables)
- [Base de Conocimiento Personal](#base-de-conocimiento-personal)
- [Catálogo de Proyectos](#catálogo-de-proyectos)
- [Configuraciones Compartidas](#configuraciones-compartidas)
- [Integración con Git y Commits](#integración-con-git-y-commits)
- [Integración con MCP Servers](#integración-con-mcp-servers)
- [Integración con Comandos Personalizados](#integración-con-comandos-personalizados-slash-commands)
- [Integración con Clean Architecture](#integración-con-clean-architecture)
- [Integración con Scrum y Agile](#integración-con-scrum-y-agile)
- [Automatizaciones y Scripts](#automatizaciones-y-scripts)
- [Roadmap](#roadmap)
- [Cómo Agregar una Nueva Tecnología](#cómo-agregar-una-nueva-tecnología)
- [Cómo Agregar un Nuevo Proyecto](#cómo-agregar-un-nuevo-proyecto)
- [Estrategia de Escalabilidad](#estrategia-de-escalabilidad)
- [Estrategia de Mantenimiento](#estrategia-de-mantenimiento)
- [Estrategia de Versionado](#estrategia-de-versionado)
- [Convenciones de Nomenclatura](#convenciones-de-nomenclatura)
- [Librerías y Herramientas Recomendadas](#librerías-y-herramientas-recomendadas)

---

## Filosofía y Principios de Diseño

| Principio | Descripción |
|-----------|-------------|
| **Convention over Configuration** | Patrones consistentes que reducen carga cognitiva. Las decisiones están tomadas; solo hay que seguirlas. |
| **Layered Context** | La especificidad aumenta en cada capa: global → tecnología → proyecto → sprint → tarea. |
| **Composable Rules** | Las reglas se componen desde partials reutilizables. Cero duplicación. |
| **Self-Documenting** | Cada carpeta tiene un `AGENTS.md` o `README.md` que explica su propósito. |
| **Tool-Agnostic** | Funciona con cualquier asistente de codificación IA. No hay dependencia de una herramienta específica. |
| **Extensible** | Diseñado para soportar múltiples tecnologías. Arquitectura abierta para más. |
| **Scale Horizontally** | Los proyectos son carpetas planas dentro de `projects/`. Sin registros centrales más allá de un índice. |
| **DRY Above All** | Las reglas globales se heredan; las de tecnología extienden; las de proyecto refinan. Nunca se repiten. |

---

## Estructura del Workspace

```
ai-developer-workspace/
│
├── .opencode/                  # Configuración del agente OpenCode
│   ├── settings.json           #   Settings globales del workspace
│   ├── agents/                 #   Definiciones de agentes personalizados
│   ├── skills/                 #   Skills reutilizables para tareas específicas
│   └── permissions/            #   Reglas de permisos por acción/tool
│
├── rules/                      # ★ REGLAS JERÁRQUICAS (corazón del sistema)
│   ├── global/
│   │   ├── mandatory.md        #   Reglas no-negociables (seguridad, calidad, comportamiento AI)
│   │   ├── AGENTS.md           #   Reglas globales de comunicación, workflow y git hygiene
│   │   └── partials/           #   Fragmentos reutilizables (code-standards)
│   ├── accelerator-sap-vue/AGENTS.md # Reglas: Vue 3 + CAP + SAP BTP + Fiori
│   └── _template/AGENTS.md     #   Template para añadir nuevas tecnologías
│
├── prompts/                    # ★ BIBLIOTECA DE PROMPTS REUTILIZABLES
│   └── global/                 #   Prompts cross-tech
│       ├── partial-stash-review.md
│       └── partial-pr-review.md
│
├── knowledge-base/             # ★ CONOCIMIENTO PERSONAL (memoria del equipo)
│   ├── architecture/           #   Diagramas, overviews, decisiones arquitectónicas
│   ├── patterns/               #   Clean Architecture, DDD, patrones de diseño
│   ├── decisions/              #   ADRs (Architecture Decision Records)
│   │   ├── ADR-template.md
│   │   └── ADR-001-workspace-structure.md
│   ├── learnings/              #   "What I Learned Today" — log continuo de aprendizajes
│   ├── cheatsheets/            #   Atajos: Git, Docker, CLI, VSCode
│   └── glossary/               #   Términos de AI Engineering y MCP
│
├── projects/                   # ★ CATÁLOGO DE PROYECTOS
│   ├── PROJECTS_INDEX.md       #   Tabla maestro con todos los proyectos
│   └── deprati/AGENTS.md       #   Proyecto activo: Deprati (SAP + Vue)
│
├── config/                     # ★ CONFIGURACIONES COMPARTIDAS
│   ├── shared/                 #   .editorconfig, .gitattributes, commitlint
│   │   └── commitlint.config.js
│   └── accelerator-sap-vue/    #   Prettier + CDS config for SAP Vue
│       └── .prettierrc
│
├── scripts/                    # ★ AUTOMATIZACIONES
│   ├── commands/sync-commands.sh #   Sincroniza comandos /qubik-*
│   ├── docs/                   #   Generadores de documentación
│   │   ├── generate.sh         #     Generador maestro (AUTO markers)
│   │   └── generate-scripts-ref.sh # Scripts reference auto-generator
│   ├── hooks/pre-commit.sh     #   Pre-commit hook (auto-docs)
│   ├── knowledge/sync.sh       #   Sincroniza symlinks de knowledge-base
│   ├── mcp/sync.sh             #   Sincroniza MCP servers externos
│   ├── project/new-project.sh  #   Scaffolding de nuevos proyectos
│   ├── shared/setup-workspace.sh # Setup inicial del workspace
│   ├── utils/                  #   Utilidades
│   │   ├── register-technology.sh
│   │   └── validate-rules.sh
│   └── doctor.sh               #   Diagnóstico completo del workspace
│
├── mcp/                        # ★ MCP SERVERS (Model Context Protocol)
│   ├── README.md               #   Documentación de MCP
│   └── servers/                #   Definiciones de servidores MCP
│
├── docs/                       # ★ DOCUMENTACIÓN TÉCNICA
│   ├── architecture/           #   Guías de arquitectura (Clean Architecture)
│   │   └── clean-architecture-guide.md
│   ├── guide/                  #   Guía principal del workspace
│   │   ├── workspace-reference.md #   Este archivo
│   │   └── scripts-reference.md   #   Referencia de scripts (auto-generado)
│   ├── guides/                 #   How-tos adicionales
│   │   ├── how-to-add-technology.md
│   │   ├── libraries-and-tools.md
│   │   └── scrum-agile-integration.md
│   └── references/             #   Registro de tecnologías y referencias
│       ├── technologies.json
│       └── technologies.md
│
├── AGENTS.md                   # Entry point para agentes IA (punto de entrada)
├── README.md                   # Guía de uso diario
└── .gitignore                  # Ignorados globales del workspace
```

---

## Arquitectura en 5 Capas

El workspace organiza el contexto en **5 capas** con especificidad creciente. Cada capa puede heredar y refinar reglas de la capa anterior.

```
┌──────────────────────────────────────────────────────────────────┐
│ CAPA 1: GLOBAL (workspace root)                                  │
│ ├── rules/global/mandatory.md    → No negociable, siempre activo  │
│ ├── rules/global/AGENTS.md       → Buenas prácticas globales      │
│ ├── prompts/global/              → Prompts para cualquier tech   │
│ ├── config/shared/               → Configs cross-tech            │
│ └── scripts/shared/              → Automatizaciones globales     │
├──────────────────────────────────────────────────────────────────┤
│ CAPA 2: PROJECT DISPATCH (projects/<project>/AGENTS.md)          │
│ ├── El proyecto declara su tecnología aquí                       │
│ └── "Technology: accelerator-sap-vue" → carga rules/accelerator-sap-vue/ │
├──────────────────────────────────────────────────────────────────┤
│ CAPA 3: TECHNOLOGY (rules/<tech>/)                                │
│ ├── rules/accelerator-sap-vue/AGENTS.md   → Reglas SAP + Vue     │
├──────────────────────────────────────────────────────────────────┤
│ CAPA 4: PROJECT (projects/<project-name>/)                        │
│ ├── AGENTS.md                    → (ya leído en dispatch)        │
│ ├── rules/                       → Reglas específicas del proyecto│
│ └── prompts/                     → Prompts específicos            │
├──────────────────────────────────────────────────────────────────┤
│ CAPA 5: SPRINT (projects/<project>/sprints/<sprint-n>/)           │
│ ├── sprint-goals.md              → Meta del sprint               │
│ ├── tasks.md                     → Desglose de tareas            │
│ ├── progress.md                  → Log diario del agente AI      │
│ └── retrospective.md             → Notas de retrospectiva        │
├──────────────────────────────────────────────────────────────────┤
│ CAPA 6: TASK (dentro del código)                                  │
│ ├── .spec.md                     → Especificación de la tarea    │
│ ├── implementation.md            → Plan de implementación        │
│ └── notes.md                     → Notas de trabajo              │
└──────────────────────────────────────────────────────────────────┘
```

### Orden de Resolución de Contexto

Cuando un agente IA comienza una tarea, resuelve el contexto en este orden:

1. `rules/global/mandatory.md` — reglas no-negociables (seguridad, calidad)
2. `rules/global/AGENTS.md` — buenas prácticas globales
3. `projects/<project>/AGENTS.md` — **el proyecto declara su tecnología aquí**. El agente lee esto ANTES de las reglas de tecnología.
4. `rules/<technology>/AGENTS.md` — reglas específicas cargadas según lo que el proyecto declaró
5. `prompts/<category>/` — prompts reutilizables según el tipo de tarea
6. `knowledge-base/<topic>/` — material de referencia según necesidad

### Modelo de Herencia

```
Global Rules (siempre cargadas)
  └── Project AGENTS.md (declara tecnología → dispacha a tech rules)
       └── Technology Rules (cargadas según lo que declaró el proyecto)
            └── Project Base Rules (si existen, desde \$<NAME>_BASE_PROJECT_PATH)
                 └── Project Rules (específicas del proyecto)
                      └── Task Context (instrucciones de la tarea)
```

Las capas superiores pueden **refinar pero no anular** las reglas obligatorias de las capas inferiores.

---

## Tecnologías Soportadas

<!-- AUTO:technologies -->
| Tecnología | Versión | Framework/Build | Estado |
|-----------|---------|-----------------|--------|
| **SAP CAP + Vue 3** | — | Vue 3 + CAP + SAP BTP, Fiori Design | ✅ Active |
<!-- /AUTO -->

---

## Uso para Agentes IA

Este workspace está optimizado para que cualquier agente IA entienda el contexto en segundos.

### Para OpenCode

El archivo `.opencode/settings.json` configura automáticamente el agente al abrir el workspace. El agente carga `rules/global/AGENTS.md` y `rules/global/mandatory.md` por defecto.

### Para Claude Code / Gemini CLI

El agente debe leer `AGENTS.md` (raíz) para orientarse, luego seguir el orden de resolución de contexto.

### Para Cursor / Windsurf

Las reglas se mapean a `.cursorrules` o se configuran en el IDE. Workspace settings recomendados en `config/ide/`.

### Flujo de Trabajo Recomendado

```
1. Leer AGENTS.md (raíz)             → Contexto general
2. Leer rules/global/mandatory.md    → Reglas no-negociables
3. Leer projects/<proyecto>/AGENTS.md→ Declara la tecnología
4. Cargar rules/<tech>/AGENTS.md   → Reglas de la tecnología
5. Si aplica, cargar prompt parcial  → prompts/<categoria>/partial-*.md
6. Consultar knowledge-base/         → Si necesita referencias
```

---

## Reglas y Políticas

### Reglas No-Negociables (`rules/global/mandatory.md`)

Estas reglas **siempre** aplican. Ningún agente o desarrollador puede evitarlas:

- **Seguridad**: No loguear secretos, no committear credenciales, validar inputs, usar queries parametrizadas.
- **Calidad**: Ejecutar linter siempre, funciones pequeñas (< 20 líneas), código muerto se elimina (no se comenta).
- **Comportamiento AI**: Preguntar antes de acciones destructivas, leer antes de editar, explicar comandos no triviales, respetar .gitignore, mantenerse en la tarea.

### Reglas Globales (`rules/global/AGENTS.md`)

- Comunicación concisa (1-3 oraciones)
- Incluir archivo:línea al referenciar código
- Flujo: **Read → Plan → Execute → Verify**
- Commits con formato `tipo(scope): descripción`
- Tipos permitidos: `feat`, `fix`, `refactor`, `docs`, `chore`, `perf`, `style`

### Reglas por Tecnología

Cada tecnología tiene su propio `rules/<tech>/AGENTS.md` con:

- **Accelerator SAP + Vue.js**: Vue 3 Composition API + CAP (CDS, OData, HANA), Pinia, SAP Fiori / Fundamental Library, XSUAA, SAP BTP deploy

---

## Prompts Reutilizables

Los prompts están organizados en `prompts/` y usan el prefijo `partial-` para indicar que son fragmentos componibles.

<!-- AUTO:prompts -->
| Prompt | Propósito |
|--------|-----------|
| `global/partial-pr-review.md` | Pull Request Review Prompt |
| `global/partial-stash-review.md` | Staged Changes Review Prompt |
<!-- /AUTO -->

Para cargar un prompt parcial durante una tarea, el agente IA debe leer el contenido del archivo y aplicarlo al contexto actual.

---

## Base de Conocimiento Personal

La carpeta `knowledge-base/` funciona como la **memoria del equipo**. Todo conocimiento que se adquiere una vez se documenta aquí para siempre.

| Subcarpeta | Propósito | Archivos de ejemplo |
|-----------|-----------|---------------------|
| `architecture/` | Diagramas, overviews, mapas del workspace | `workspace-overview.md` |
| `patterns/` | Patrones arquitectónicos y de diseño | `clean-architecture.md` |
| `decisions/` | Architecture Decision Records (ADRs) | `ADR-001-workspace-structure.md` |
| `learnings/` | Log "What I Learned Today" | `what-i-learned-today.md` |
| `cheatsheets/` | Atajos y comandos de referencia rápida | `git-commands.md` |
| `glossary/` | Definiciones de términos técnicos | `ai-terms.md` |

### Arquitectura de Decisiones (ADR)

Cada decisión arquitectónica significativa se registra como un ADR numerado secuencialmente:

```
ADR-<NNN>: <Título>

Status: [Proposed | Accepted | Deprecated | Superseded]
Date: YYYY-MM-DD

Context → Decision → Consequences → Alternatives Considered → Related Decisions
```

---

## Catálogo de Proyectos

Todos los proyectos se registran en `projects/PROJECTS_INDEX.md`. Cada proyecto vive en su propia carpeta `projects/<project-name>/`:

```
projects/<project-name>/
├── AGENTS.md           # Descripción, tech stack, arquitectura, equipo
├── rules/              # Reglas específicas del proyecto (opcional)
├── prompts/            # Prompts específicos (opcional)
├── sprints/            # Sprints (si aplica Scrum)
└── docs/              # Documentación del proyecto
```

Los proyectos externos pueden referenciar el workspace via:
- **Opción A**: Colocar el proyecto dentro de `projects/<name>/`
- **Opción B**: Variable de entorno `OPENCODE_WORKSPACE` apuntando aquí
- **Opción C**: Symlink desde `projects/<name>` a la ubicación externa

---



## Configuraciones Compartidas

### Cross-Tech (`config/shared/`)

| Archivo | Propósito |
|---------|-----------|
| `.editorconfig` | Consistencia de editor (indentación, encoding, line endings) |
| `.gitattributes` | Normalización de archivos (text vs binary, LFs vs CRLFs) |
| `commitlint.config.js` | Validación de mensajes de commit (Conventional Commits) |

### Por Tecnología

| Archivo | Propósito |
|---------|-----------|
| `config/accelerator-sap-vue/.prettierrc` | Prettier config para SAP Vue |
| `config/ide/.vscode-extensions.json` | Extensiones VSCode recomendadas |

### IDE Settings Recomendados

Las extensiones VSCode recomendadas incluyen: Volar (Vue), ESLint, Prettier, Docker, GitHub Actions, GitLens, Markdown All-in-One, SAP CDS Language Support.

---

## Integración con Git y Commits

### Formato de Commits

```
<tipo>(<scope>): <descripción>

Ejemplos:
  feat(auth): add login endpoint
  fix(cart): resolve NPE when cart is empty
  refactor(checkout): extract payment validation
  docs(api): update OpenAPI spec
  chore(deps): upgrade @sap/cds to 8.0.0
  perf(query): optimize N+1 in OrderRepository
  style(lint): fix formatting issues
```

### Tipos Permitidos

| Tipo | Uso |
|------|-----|
| `feat` | Nueva funcionalidad |
| `fix` | Corrección de bug |
| `refactor` | Reestructuración de código sin cambio funcional |
| `docs` | Documentación |
| `chore` | Mantenimiento (build, dependencias, tooling) |
| `perf` | Mejora de rendimiento |
| `style` | Formato, linting (sin cambio funcional) |

### Buenas Prácticas

- Commits atómicos: un cambio lógico por commit
- No modificar commits pusheados (`--amend` solo para commits locales)
- No hacer `force push` sin permiso explícito
- Mensajes en inglés (por consistencia global)
- Scope en kebab-case

---



## Integración con MCP Servers

El workspace soporta el **Model Context Protocol (MCP)** para que los agentes IA interactúen con sistemas externos de forma estandarizada.

### Estructura (`mcp/`)

<!-- AUTO:mcp -->
```
mcp/
├── README.md                 # Documentación MCP
├── servers/                  # Definiciones de servidores MCP
│   ├── browser.json
│   ├── deprati-mcp.json
│   ├── figma-mcp.json
│   ├── filesystem.json
│   ├── obsidian.json
└── tools/                    # Herramientas personalizadas
```

### Servidores Incluidos

| Servidor | Descripción |
|----------|-------------|
| `browser` | Browser automation for testing web apps — controla Chrome/Edge con IA |
| `deprati-mcp` | MCP server for Deprati project documentation and code knowledge (RAG sobre features, endpoints, specs) |
| `figma-mcp` | Figma design tokens and assets access via figma-developer-mcp |
| `filesystem` | Secure file system access for AI agents — limitado al workspace root |
| `obsidian` | Acceso al vault de Obsidian (knowledge-base) — leer, buscar, crear y editar notas markdown |
<!-- /AUTO -->

Los paths de los servidores usan variables de entorno (`$DEPRATI_BASE_PROJECT_PATH`) en lugar de rutas absolutas.

### Sincronizar MCPs desde proyecto externo

```bash
./scripts/mcp/sync.sh deprati
```

Esto enlaza los MCP servers definidos en `$DEPRATI_BASE_PROJECT_PATH/.opencode/mcp/servers/` como `ext.*.json` en `mcp/servers/`.

### Agregar un Servidor

```json
// mcp/servers/mi-servidor.json
{
  "name": "mi-servidor",
  "command": "bash",
  "args": ["-c", "node \"$RUTA_PROYECTO/dist/server.js\""],
  "env": {
    "API_KEY": "${API_KEY}"
  }
}
```

---

## Integración con Comandos Personalizados (Slash Commands)

El workspace soporta la sincronización de **comandos slash** (`/comando`) desde proyectos externos, siguiendo el mismo patrón que los MCP servers.

### Sincronización desde `$DEPRATI_BASE_PROJECT_PATH`

```bash
./scripts/commands/sync-commands.sh
```

Este script:
1. Lee `$DEPRATI_BASE_PROJECT_PATH` del `.env`
2. Escanea `$DEPRATI_BASE_PROJECT_PATH/.opencode/commands/` buscando archivos `.md`
3. Crea symlinks en `.opencode/commands/` para que OpenCode los descubra automáticamente

### Comandos incluidos

| Comando | Descripción |
|---------|-------------|
| `/f-agent ${projectName}` | Activa el contexto de un proyecto (resuelve rutas reales desde env vars) |
| `/f-review-changes ${projectName}` | Revisa cambios staged pendientes de commit |
| `/f-review-pr ${projectName} <pr-id>` | Revisa un Pull Request usando `gh` |
| `/qubik-*` | Comandos Qubik SDD Framework (sincronizados desde proyecto externo) |

### ¿Cómo se vinculan los comandos?

```
$DEPRATI_BASE_PROJECT_PATH/.opencode/commands/<cualquier-carpeta>/*.md
  └── symlinks → .opencode/commands/<nombre>.md
                 (OpenCode los carga automáticamente)
```

### Crear un comando nuevo

Los comandos se definen en `.opencode/commands/<nombre>.md` con frontmatter `---description:...---` y pueden incluir prompts con `@` y ejecutar comandos con `` !`...` ``.

---

## Integración con Clean Architecture

El workspace incluye una guía de Clean Architecture adaptada a Accelerator SAP + Vue.js.

### Principio Fundamental

> Las dependencias del código fuente apuntan **hacia adentro**. Nada en el círculo interno puede conocer algo del círculo externo.

### Capas

| Capa | Responsabilidad | Dependencias |
|------|----------------|--------------|
| **Domain** (inner) | Entidades, Value Objects, reglas de negocio | Cero |
| **Application** | Casos de uso, puertos, DTOs | Solo Domain |
| **Infrastructure** (outer) | Repositorios, clientes API, controladores | Implementa puertos |

### Ejemplo

```
src/app/
├── core/
│   ├── domain/          → Modelos, interfaces de puertos, servicios de dominio
│   └── application/     → Casos de uso, puertos de salida
├── infrastructure/      → Repositorios HTTP, NgRx store, efectos
└── presentation/        → Componentes, páginas, pipes
```

---



## Integración con Scrum y Agile

El workspace soporta Scrum/Agile a nivel de proyecto, con estructura para sprints, backlog y retrospectivas.

### Estructura por Proyecto

```
projects/<project>/
├── AGENTS.md              # Contexto épico del proyecto
├── sprints/
│   ├── sprint-01/
│   │   ├── sprint-goals.md    # Meta y alcance del sprint
│   │   ├── tasks.md           # Desglose de tareas
│   │   ├── progress.md        # Progreso diario (log del agente AI)
│   │   └── retrospective.md   # Notas de retrospectiva
│   ├── sprint-02/
│   └── current/               # Symlink al sprint activo
└── prompts/
    └── daily-standup.md       # Prompt para daily standup del agente AI
```

### Ceremonias con Asistencia AI

| Ceremonia | Rol del Agente AI |
|-----------|-------------------|
| **Refinement** | Revisar specs por claridad, sugerir acceptance criteria, estimar esfuerzo |
| **Planning** | Descomponer historias en tareas, identificar dependencias |
| **Daily Standup** | Reportar progreso en tareas activas, señalar blockers |
| **Review** | Resumir trabajo completado, demostrar funcionalidades |
| **Retro** | Analizar métricas, sugerir mejoras al proceso |

### Flujo de Sprint

1. **Sprint Planning**: PO escribe specs → AI refina AC → tareas se desglosan
2. **Durante el Sprint**: AI carga contexto del sprint → trabaja tareas en orden → logra progreso
3. **Review/Retro**: AI resume completado → equipo revisa → retro capturada → mejoras aplicadas

---

## Automatizaciones y Scripts

<!-- AUTO:scripts -->
| Script | Propósito | Uso |
|--------|-----------|-----|
| `scripts/commands/sync-commands.sh` | Sincroniza comandos slash (/qubik-*) desde un proyecto externo hacia .opencode/commands/. Lee DEPRATI_BASE_PROJECT_PATH del .env. | `./scripts/commands/sync-commands.sh` |
| `scripts/docs/generate-scripts-ref.sh` | Genera automáticamente docs/guide/scripts-reference.md a partir de los doc headers estandarizados en cada script .sh. Se ejecuta como pre-commit hook cuando scripts/ cambia, o manualmente cuando se desee. | `./scripts/docs/generate-scripts-ref.sh` |
| `scripts/docs/generate.sh` | Generador maestro de documentación. Escanea el estado real del workspace y actualiza las secciones marcadas con <!-- AUTO: --> en docs/guide/workspace-reference.md. También regenera scripts-reference.md. | `./scripts/docs/generate.sh` |
| `scripts/doctor.sh` | Diagnóstico completo del workspace. Verifica variables de entorno, directorios externos, MCP servers, estructura de reglas, y dependencias. | `./scripts/doctor.sh [project]` |
| `scripts/hooks/pre-commit.sh` | Pre-commit hook que regenera automáticamente docs/guide/scripts-reference.md cuando hay cambios en scripts/. Instalado por setup-workspace.sh como symlink en .git/hooks/pre-commit. | `(se ejecuta automáticamente en git commit)` |
| `scripts/knowledge/sync.sh` | Sincroniza symlinks en knowledge-base/_proyectos/ con las variables de entorno *_BASE_PROJECT_PATH. Crea enlaces a la documentación externa de cada proyecto (specs, ADRs, docs, rules). | `./scripts/knowledge/sync.sh` |
| `scripts/mcp/sync.sh` | Sincroniza definiciones de MCP servers desde un proyecto externo hacia mcp/servers/. Soporta dos formatos:   1) Archivos .json individuales en .opencode/mcp/servers/ (symlink)   2) .mcp.json en la raíz del proyecto externo (conversión automática a      formato OpenCode, con prefijo ext.) | `./scripts/mcp/sync.sh <project>` |
| `scripts/project/new-project.sh` | Crea un nuevo proyecto a partir de un template registrado en technologies.json. Copia la estructura del template, genera AGENTS.md, y actualiza PROJECTS_INDEX.md. | `./scripts/project/new-project.sh <name> <type> [path]` |
| `scripts/shared/setup-workspace.sh` | Setup inicial del workspace. Verifica prerequisitos (git, docker, jq, node) y crea los directorios base necesarios. | `./scripts/shared/setup-workspace.sh` |
| `scripts/utils/register-technology.sh` | Registra una nueva tecnología en el workspace. Crea las carpetas en rules/, prompts/, config/, templates/ y añade la entrada en technologies.json. | `./scripts/utils/register-technology.sh <key> <name>` |
| `scripts/utils/validate-rules.sh` | Valida la integridad del workspace: verifica que toda carpeta rules/ tenga su AGENTS.md, que el registro de tecnologías coincida con la estructura real, y detecta carpetas huérfanas. | `./scripts/utils/validate-rules.sh` |
<!-- /AUTO -->

### new-project.sh

```bash
# Crear proyecto SAP + Vue
./scripts/project/new-project.sh frontend-app accelerator-sap-vue

# (más tecnologías disponibles cuando se agreguen al workspace)
```

---

## Roadmap

### Phase 1: Foundation ✅

- [x] Diseño de estructura (arquitectura en 5 capas)
- [x] Reglas globales y políticas obligatorias
- [x] Reglas por tecnología (Accelerator SAP + Vue.js)
- [x] Prompts reutilizables globales
- [x] Configuraciones compartidas
- [x] Catálogo de proyectos
- [x] Scripts de setup
- [x] Definiciones de servidores MCP
- [x] Documentación de arquitectura
- [x] Guía de Clean Architecture
- [x] Guía de Scrum/Agile
- [x] Primer ADR (ADR-001)

### Phase 2: Templates & Tooling

- [ ] Template SAP + Vue completo (Vue 3 + CAP + Fiori)
- [ ] Template librería (TypeScript dual ESM/CJS)
- [ ] Generador de configs IDE (VSCode, JetBrains)

### Phase 3: Knowledge & Automation

- [ ] Escaneo semanal de dependencias (Renovate)
- [ ] Búsqueda cross-project
- [ ] Indexación de knowledge-base para RAG
- [ ] Gestión automatizada de ADRs

### Phase 4: MCP & Agent Ecosystem

- [ ] Servidor MCP de GitHub (issues, PRs, actions)
- [ ] Tools MCP personalizadas
- [ ] Skills para code review, refactoring
- [ ] Orquestación multi-agente

### Phase 5: Scaling & Governance

- [ ] Integración con monorepos (Nx, Turborepo)
- [ ] Ciclo de vida de proyectos
- [ ] Permisos por rol para agentes
- [ ] Reglas de compliance
- [ ] Métricas y observabilidad

### Phase 6: Advanced AI Integration

- [ ] Pipeline RAG usando la knowledge base
- [ ] ADRs generados por AI
- [ ] Estimación predictiva de tareas
- [ ] Consultas en lenguaje natural

---

## Cómo Agregar una Nueva Tecnología

Ver `docs/guides/how-to-add-technology.md`.

---

## Cómo Agregar un Nuevo Proyecto

### Opción 1: Script Automatizado

```bash
./scripts/project/new-project.sh mi-proyecto accelerator-sap-vue
```

Esto crea `projects/mi-proyecto/` con:
- `AGENTS.md` con datos básicos del proyecto
- Subdirectorios `docs/`, `scripts/`, `rules/`
- Entrada añadida a `projects/PROJECTS_INDEX.md`

### Opción 2: Manual

```bash
# 1. Crear carpeta
mkdir -p projects/mi-proyecto

# 2. Crear AGENTS.md con contexto del proyecto
# 3. Agregar al índice en projects/PROJECTS_INDEX.md
```

### Estructura Mínima de un Proyecto

```
projects/mi-proyecto/
├── AGENTS.md           # ← OBLIGATORIO: contexto para el agente AI
├── docs/               # Documentación del proyecto
├── rules/              # Reglas específicas (opcional)
└── prompts/            # Prompts específicos (opcional)
```

---

## Estrategia de Escalabilidad

### Para Decenas de Proyectos (1-50)

La estructura plana de `projects/<name>/` funciona sin modificaciones. Cada proyecto es independiente, no hay acoplamiento.

### Para Cientos de Proyectos (50-500)

```
projects/
├── fintech/
│   ├── payments-api/
│   ├── fraud-detection/
│   └── ledger-service/
├── ecommerce/
│   ├── storefront/
│   ├── inventory/
│   └── shipping/
└── internal/
    ├── hr-portal/
    └── asset-management/
```

### Para Proyectos Externos

```bash
# Symlink a proyectos que viven fuera del workspace
ln -s "$EXTERNAL_PROJECT_PATH" projects/external-api
```

### Claves de Escalabilidad

1. **Sin acoplamiento**: Cada proyecto es una carpeta independiente.
2. **Sin duplicación**: Las reglas se heredan por capas.
3. **Descubrimiento predecible**: El orden de resolución de contexto es siempre el mismo.
4. **Bajo costo de entrada**: Agregar un proyecto = copiar template + editar AGENTS.md.

---

## Estrategia de Mantenimiento

### Mantenimiento de Reglas

| Acción | Frecuencia | Responsable |
|--------|-----------|-------------|
| Revisar reglas globales | Trimestral | Arquitecto |
| Actualizar reglas de tecnología | Por major version | Tech Lead |
| Validar estructura de reglas | Cada PR | CI / validate-rules.sh |
| Archivar reglas obsoletas | Cuando se depreca una tecnología | Arquitecto |

### Mantenimiento de Prompts

- Los prompts se versionan junto con el workspace
- Se revisan cuando se identifica un patrón recurrente
- Los prompts obsoletos se mueven a `prompts/_archive/`

### Mantenimiento de Knowledge Base

- **ADRs**: Se agregan cuando se toma una decisión arquitectónica significativa
- **Learnings**: Se actualizan continuamente (fecha + aprendizaje + tags)
- **Cheatsheets**: Se actualizan cuando cambian herramientas o comandos

### Validación Automática

```bash
./scripts/utils/validate-rules.sh
# Verifica:
# - Toda carpeta rules/ tiene su AGENTS.md
# - Toda tecnología registrada tiene su carpeta de reglas
# - No hay carpetas huerfanas sin documentación
```

---

## Estrategia de Versionado

### Versiones del Workspace

El workspace usa **Semantic Versioning** (SemVer):

```
MAJOR.MINOR.PATCH

MAJOR: Cambios que rompen compatibilidad (reestructuración mayor)
MINOR: Nuevas funcionalidades (nuevas tecnologías, nuevas reglas)
PATCH: Correcciones (bugs en scripts, ajustes menores)
```

### Versionado de Proyectos

Cada proyecto gestiona su propio versionado independientemente:
- **Semantic Release** para librerías (versionado automático desde commits)
- **Git tags** con prefijo del proyecto: `mi-proyecto/v1.2.3`
- **CHANGELOG.md** en formato Keep a Changelog

### Versionado de ADRs

Los ADRs se numeran secuencialmente (ADR-001, ADR-002...). Cuando un ADR es supersedido, se actualiza su estado y se referencia al ADR que lo reemplaza.

### Commits Convencionales

Todos los commits siguen [Conventional Commits](https://www.conventionalcommits.org/):

```
feat(workspace): add FastAPI technology support
fix(scripts): resolve path issue in new-project.sh
docs(readme): update MCP integration section
```

---

## Convenciones de Nomenclatura

| Elemento | Convención | Ejemplo |
|----------|-----------|---------|
| **Carpetas** | `kebab-case` | `knowledge-base` |
| **Documentos** | `PascalCase.md` | `README.md`, `AGENTS.md` |
| **Prompts parciales** | `partial-*.md` | `partial-stash-review.md` |
| **Keys de tecnología** | `kebab-case` | `accelerator-sap-vue` |
| **Nombres de proyecto** | `kebab-case` | `my-app` |
| **Nombres de script** | `kebab-case.sh` | `sync.sh`, `new-project.sh` |
| **Archivos de reglas** | `AGENTS.md` | Siempre `AGENTS.md` |
| **READMEs** | `README.md` | Solo para documentación de usuario |
| **Configuraciones** | `.prettierrc`, `.eslintrc.json` | Convención de la herramienta |

| **Archivos de workflow** | `*.yml` | `ci.yml`, `deploy.yml` |
| **Archivos de MCP** | `kebab-case.json` | `filesystem.json` |
| **Archivos de spec** | `kebab-case.md` | `feature-spec.md` |
| **Extensiones** | Específicas del lenguaje | `.ts`, `.vue`, `.java`, `.cds` |

---

## Librerías y Herramientas Recomendadas

### Cross-Platform

| Herramienta | Propósito |
|-------------|-----------|
| **pnpm** | Package manager para JS/TS |
| **Docker** | Contenedores para entornos estandarizados |
| **Make** | Task runner cross-platform |
| **CommitLint** | Validación de mensajes de commit |
| **EditorConfig** | Consistencia entre editores |
| **Prettier** | Formateo de código JS/TS/HTML/CSS |
| **Renovate** | Actualización automática de dependencias |
| **Snyk / Trivy** | Escaneo de seguridad |

### Accelerator SAP + Vue.js

Vue 3 + Composition API, SAP CAP (cds), Pinia, Fundamental Library / UI5, SAP Cloud SDK.

---

*AI Developer Workspace — Construido para agentes IA, diseñado por humanos.*
