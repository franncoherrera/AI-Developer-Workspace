# AI Developer Workspace

**Un entorno centralizado para desarrollo asistido por inteligencia artificial.**

Este workspace está diseñado para que asistentes de IA como **OpenCode**, **Claude Code**, **Gemini CLI**, **Cursor**, **Windsurf** y **GitHub Copilot** puedan operar de forma consistente, predecible y productiva a través de múltiples proyectos y tecnologías.

---

## Tabla de Contenidos

- [Filosofía y Principios de Diseño](#filosofía-y-principios-de-diseño)
- [Estructura del Workspace](#estructura-del-workspace)
- [Arquitectura en 5 Capas](#arquitectura-en-5-capas)
- [Tecnologías Soportadas](#tecnologías-soportadas)
- [Guía Rápida de Inicio](#guía-rápida-de-inicio)
- [Uso para Agentes IA](#uso-para-agentes-ia)
- [Reglas y Políticas](#reglas-y-políticas)
- [Prompts Reutilizables](#prompts-reutilizables)
- [Base de Conocimiento Personal](#base-de-conocimiento-personal)
- [Catálogo de Proyectos](#catálogo-de-proyectos)
- [Templates de Proyectos](#templates-de-proyectos)
- [Configuraciones Compartidas](#configuraciones-compartidas)
- [Integración con Git y Commits](#integración-con-git-y-commits)
- [Integración con Docker](#integración-con-docker)
- [Integración con MCP Servers](#integración-con-mcp-servers)
- [Integración con Clean Architecture](#integración-con-clean-architecture)
- [Integración con Spec-Driven Development](#integración-con-spec-driven-development)
- [Integración con Scrum y Agile](#integración-con-scrum-y-agile)
- [Automatizaciones y Scripts](#automatizaciones-y-scripts)
- [Roadmap](#roadmap)
- [Cómo Agregar una Nueva Tecnología](#cómo-agregar-una-nueva-tecnología)
- [Cómo Agregar un Nuevo Proyecto](#cómo-agregar-un-nuevo-proyecto)
- [Estrategia de Escalabilidad](#estrategia-de-escalabilidad)
- [Estrategia de Mantenimiento](#estrategia-de-mantenimiento)
- [Estrategia de Versionado](#estrategia-de-versionado)
- [Convenciones de Nomenclatura](#convenciones-de-nomenclatura)

---

## Filosofía y Principios de Diseño

| Principio | Descripción |
|-----------|-------------|
| **Convention over Configuration** | Patrones consistentes que reducen carga cognitiva. Las decisiones están tomadas; solo hay que seguirlas. |
| **Layered Context** | La especificidad aumenta en cada capa: global → tecnología → proyecto → sprint → tarea. |
| **Composable Rules** | Las reglas se componen desde partials reutilizables. Cero duplicación. |
| **Self-Documenting** | Cada carpeta tiene un `AGENTS.md` o `README.md` que explica su propósito. |
| **Tool-Agnostic** | Funciona con cualquier asistente de codificación IA. No hay dependencia de una herramienta específica. |
| **Polyglot Ready** | Diseñado para soportar múltiples tecnologías. Actualmente Angular; arquitectura abierta para más. |
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
│   │   └── partials/           #   Fragmentos reutilizables (code-standards, testing)
│   ├── angular/AGENTS.md       #   Reglas específicas: Standalone Components, Signals, NgRx
│   └── _template/AGENTS.md     #   Template para añadir nuevas tecnologías
│
├── prompts/                    # ★ BIBLIOTECA DE PROMPTS REUTILIZABLES
│   ├── global/                 #   Prompts cross-tech
│   │   ├── partial-code-review.md
│   │   ├── partial-implementation-plan.md
│   │   └── partial-spec-review.md
│   ├── code-review/            #   Prompts para PR descriptions
│   ├── testing/                #   Prompts para unit tests
│   └── angular/                 # Prompts específicos por tecnología
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
│   ├── _template/AGENTS.md     #   Template para incorporar un nuevo proyecto
│   └── sandbox/AGENTS.md       #   Sandbox para pruebas y experimentación
│
├── templates/                  # ★ SCAFFOLDING DE PROYECTOS
│   ├── _common/                #   Archivos base compartidos (README, gitignore, Makefile)
│   └── angular/AGENTS.md       #   Template: Angular 17+ standalone components + signals
│
├── config/                     # ★ CONFIGURACIONES COMPARTIDAS
│   ├── shared/                 #   .editorconfig, .gitattributes, commitlint
│   │   └── commitlint.config.js
│   └── angular/.eslintrc.json  #   ESLint + Angular ESLint rules
│       └── .vscode-extensions.json
│
├── scripts/                    # ★ AUTOMATIZACIONES
│   ├── project/new-project.ps1 #   Scaffolding de nuevos proyectos desde templates
│   ├── shared/setup-workspace.ps1 # Setup inicial del workspace
│   └── utils/validate-rules.ps1#   Validador de integridad de reglas
│
├── docker/                     # ★ CONTENEDORES
│   ├── docker-compose.yml      #   Servicios compartidos (PostgreSQL, Redis, MailCatcher)
│   ├── images/                 #   Dockerfile de referencia multi-stage
│   │   └── Dockerfile.node
│   ├── services/               #   Configuraciones de servicios individuales
│   └── compose/                #   Docker Compose específicos por escenario
│
├── mcp/                        # ★ MCP SERVERS (Model Context Protocol)
│   ├── README.md               #   Documentación de MCP
│   ├── servers/                #   Definiciones de servidores MCP
│   │   └── filesystem.json     #   Servidor de sistema de archivos
│   └── tools/                  #   Definiciones de herramientas personalizadas
│
├── docs/                       # ★ DOCUMENTACIÓN TÉCNICA
│   ├── architecture/           #   Guías de arquitectura (Clean Architecture)
│   │   └── clean-architecture-guide.md
│   ├── guides/                 #   How-tos y guías de uso
│   │   ├── how-to-add-technology.md
│   │   ├── libraries-and-tools.md
│   │   └── scrum-agile-integration.md
│   ├── references/             #   Registro de tecnologías y referencias
│   │   └── technologies.md
│   └── decisions/              #   Decisiones arquitectónicas adicionales
│
├── specs/                      # ★ SPEC-DRIVEN DEVELOPMENT
│   ├── templates/              #   Templates de especificaciones
│   │   ├── feature-spec.md     #     Feature spec con BDD/Gherkin
│   │   └── architecture-decision.md
│   ├── examples/               #   Ejemplos de specs completadas
│   └── projects/               #   Especificaciones activas por proyecto
│
├── workflows/                  # ★ CI/CD Y GIT HOOKS
│   ├── github/ci.yml           #   GitHub Actions CI reutilizable
│   ├── gitlab/                 #   GitLab CI (futuro)
│   ├── hooks/pre-commit.ps1    #   Pre-commit hook con secret scanning
│   └── scripts/                #   Scripts auxiliares para pipelines
│
├── AGENTS.md                   # Entry point para agentes IA (punto de entrada)
├── ARCHITECTURE.md             # Documento de arquitectura completa
├── ROADMAP.md                  # Roadmap de evolución (6 fases)
├── README.md                   # Este archivo
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
│ CAPA 2: TECHNOLOGY (rules/<tech>/)                                │
│ ├── rules/angular/AGENTS.md      → Si el proyecto es Angular     │
├──────────────────────────────────────────────────────────────────┤
│ CAPA 3: PROJECT (projects/<project-name>/)                        │
│ ├── AGENTS.md                    → Descripción, metas, equipo     │
│ ├── rules/                       → Reglas específicas del proyecto│
│ ├── prompts/                     → Prompts específicos            │
│ └── specs/                       → Especificaciones del proyecto  │
├──────────────────────────────────────────────────────────────────┤
│ CAPA 4: SPRINT (projects/<project>/sprints/<sprint-n>/)           │
│ ├── sprint-goals.md              → Meta del sprint               │
│ ├── tasks.md                     → Desglose de tareas            │
│ ├── progress.md                  → Log diario del agente AI      │
│ └── retrospective.md             → Notas de retrospectiva        │
├──────────────────────────────────────────────────────────────────┤
│ CAPA 5: TASK (dentro del código)                                  │
│ ├── .spec.md                     → Especificación de la tarea    │
│ ├── implementation.md            → Plan de implementación        │
│ └── notes.md                     → Notas de trabajo              │
└──────────────────────────────────────────────────────────────────┘
```

### Orden de Resolución de Contexto

Cuando un agente IA comienza una tarea, resuelve el contexto en este orden:

1. `rules/global/mandatory.md` — reglas no-negociables (seguridad, calidad)
2. `rules/global/AGENTS.md` — buenas prácticas globales
3. `rules/angular/AGENTS.md` — reglas específicas de Angular
4. `projects/<project>/AGENTS.md` — contexto específico del proyecto
5. `prompts/<category>/` — prompts reutilizables según el tipo de tarea
6. `knowledge-base/<topic>/` — material de referencia según necesidad

### Modelo de Herencia

```
Global Rules (siempre cargadas)
  └── Technology Rules (cargadas si se detecta la tecnología)
       └── Project Rules (cargadas si existen)
            └── Task Context (instrucciones de la tarea actual)
```

Las capas superiores pueden **refinar pero no anular** las reglas obligatorias de las capas inferiores.

---

## Tecnologías Soportadas

| Tecnología | Versión | Framework/Build | Estado |
|-----------|---------|-----------------|--------|
| **Angular** | 17+ | Angular CLI, Standalone Components, Signals | ✅ Active |

### Tecnologías Planificadas

| Tecnología | Prioridad |
|-----------|-----------|
| Spring Boot 3.x | Alta |
| Node.js 20+ | Alta |
| Ruby on Rails 7+ | Alta |
| Python (Django / FastAPI) | Media |
| Flutter / Dart | Media |
| Go (Gin / Echo) | Media |
| Next.js | Media |
| React Native | Baja |
| Rust | Baja |

Cada tecnología tiene su propio conjunto de reglas (`rules/<tech>/`), prompts (`prompts/<tech>/`), configuraciones (`config/<tech>/`) y templates (`templates/<tech>/`). Actualmente solo Angular está activo; las demás se agregarán en fases futuras.

---

## Guía Rápida de Inicio

### Prerrequisitos

- Git
- Docker Desktop (recomendado)
- PowerShell 7+
- Node.js 20+ (para tooling y proyectos JS/TS)

### Setup Inicial

```powershell
# 1. Clonar el workspace (si no está clonado)
git clone <repo-url> ai-developer-workspace
cd ai-developer-workspace

# 2. Ejecutar setup automatizado
.\scripts\shared\setup-workspace.ps1

# 3. Verificar la estructura
.\scripts\utils\validate-rules.ps1
```

### Crear un Nuevo Proyecto

```powershell
# Opción 1: Usar script automatizado
.\scripts\project\new-project.ps1 -Name "mi-app" -Type "angular"

# Opción 2: Manual (copiar template)
Copy-Item -Recurse projects/_template projects/mi-api
# Editar projects/mi-api/AGENTS.md con el contexto del proyecto
```

### Iniciar Servicios Compartidos

```powershell
docker compose -f docker/docker-compose.yml up -d
# Inicia PostgreSQL, Redis y MailCatcher para desarrollo local
```

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
3. Cargar rules/angular/AGENTS.md  → Reglas específicas de Angular
4. Leer projects/<proyecto>/AGENTS.md→ Contexto específico
5. Si aplica, cargar prompt parcial  → prompts/<categoria>/partial-*.md
6. Consultar knowledge-base/         → Si necesita referencias
```

---

## Reglas y Políticas

### Reglas No-Negociables (`rules/global/mandatory.md`)

Estas reglas **siempre** aplican. Ningún agente o desarrollador puede evitarlas:

- **Seguridad**: No loguear secretos, no committear credenciales, validar inputs, usar queries parametrizadas.
- **Calidad**: Escribir tests por cada feature, ejecutar linter siempre, funciones pequeñas (< 20 líneas), código muerto se elimina (no se comenta).
- **Comportamiento AI**: Preguntar antes de acciones destructivas, leer antes de editar, explicar comandos no triviales, respetar .gitignore, mantenerse en la tarea.

### Reglas Globales (`rules/global/AGENTS.md`)

- Comunicación concisa (1-3 oraciones)
- Incluir archivo:línea al referenciar código
- Flujo: **Read → Plan → Execute → Verify**
- Commits con formato `tipo(scope): descripción`
- Tipos permitidos: `feat`, `fix`, `refactor`, `test`, `docs`, `chore`, `perf`, `style`

### Reglas por Tecnología

Cada tecnología tiene su propio `rules/<tech>/AGENTS.md` con:

- **Angular**: Standalone Components, Signals, NgRx/SignalStore, RxJS patterns, TestBed testing

---

## Prompts Reutilizables

Los prompts están organizados en `prompts/` y usan el prefijo `partial-` para indicar que son fragmentos componibles.

| Prompt | Propósito |
|--------|-----------|
| `global/partial-code-review.md` | Template para revisiones de código con categorías Critical/Warning/Suggestion |
| `global/partial-implementation-plan.md` | Plan de implementación estructurado (archivos, cambios, dependencias, tests) |
| `global/partial-spec-review.md` | Revisión de especificaciones (claridad, completitud, factibilidad, testabilidad) |
| `testing/partial-unit-test.md` | Template para escribir tests unitarios (AAA pattern + edge cases) |
| `code-review/partial-pr-description.md` | Template de descripción de PR (summary, changes, testing, breaking changes) |

Para cargar un prompt parcial durante una tarea, el agente IA debe leer el contenido del archivo y aplicarlo al contexto actual.

---

## Base de Conocimiento Personal

La carpeta `knowledge-base/` funciona como la **memoria del equipo**. Todo conocimiento que se adquiere una vez se documenta aquí para siempre.

| Subcarpeta | Propósito | Archivos de ejemplo |
|-----------|-----------|---------------------|
| `architecture/` | Diagramas, overviews, mapas del workspace | `workspace-overview.md` |
| `patterns/` | Patrones arquitectónicos y de diseño | `clean-architecture.md` |
| `decisions/` | Architecture Decision Records (ADRs) | `ADR-001-workspace-structure.md`, `ADR-template.md` |
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

Todos los proyectos se registran en `projects/PROJECTS_INDEX.md` con:

| Project | Technology | Status | Description |
|---------|-----------|--------|-------------|

Cada proyecto vive en su propia carpeta `projects/<project-name>/` con:

```
projects/<project-name>/
├── AGENTS.md           # Descripción, tech stack, arquitectura, equipo
├── rules/              # Reglas específicas del proyecto (opcional)
├── prompts/            # Prompts específicos (opcional)
├── specs/              # Especificaciones del proyecto
├── sprints/            # Sprints (si aplica Scrum)
└── docs/              # Documentación del proyecto
```

Los proyectos externos pueden referenciar el workspace via:
- **Opción A**: Colocar el proyecto dentro de `projects/<name>/`
- **Opción B**: Variable de entorno `OPENCODE_WORKSPACE` apuntando aquí
- **Opción C**: Symlink desde `projects/<name>` a la ubicación externa

---

## Templates de Proyectos

| Template | Descripción | Variantes |
|----------|-------------|-----------|
| `angular/` | Angular 17+ standalone + signals + Material | SSR opcional, CSS framework configurable |

Cada template incluye:
- Estructura de carpetas recomendada
- Configuraciones de build, lint y test
- Dockerfile multi-stage
- CI/CD workflow (GitHub Actions)
- Documentación inicial (README, CHANGELOG, CONTRIBUTING)

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
| `config/angular/.eslintrc.json` | ESLint + Angular ESLint rules |
| `config/ide/.vscode-extensions.json` | Extensiones VSCode recomendadas |

### IDE Settings Recomendados

Las extensiones VSCode recomendadas incluyen: Angular Language Service, ESLint, Prettier, Docker, GitHub Actions, GitLens, Markdown All-in-One.

---

## Integración con Git y Commits

### Formato de Commits

```
<tipo>(<scope>): <descripción>

Ejemplos:
  feat(auth): add login endpoint
  fix(cart): resolve NPE when cart is empty
  refactor(checkout): extract payment validation
  test(order): add unit tests for OrderService
  docs(api): update OpenAPI spec
  chore(deps): upgrade angular to 18.0.0
  perf(query): optimize N+1 in OrderRepository
  style(lint): fix formatting issues
```

### Tipos Permitidos

| Tipo | Uso |
|------|-----|
| `feat` | Nueva funcionalidad |
| `fix` | Corrección de bug |
| `refactor` | Reestructuración de código sin cambio funcional |
| `test` | Adición o modificación de tests |
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

### Pre-commit Hook

El workspace incluye un pre-commit hook en `workflows/hooks/pre-commit.ps1` que:

- Escanea archivos staged en busca de posibles secretos (API keys, tokens, passwords)
- Detecta archivos grandes (>500KB) que podrían no deberirse committear
- Se instala automáticamente con `setup-workspace.ps1`

---

## Integración con Docker

### Servicios Compartidos (`docker/docker-compose.yml`)

```yaml
services:
  postgres:   # PostgreSQL 16 para todos los proyectos
  redis:      # Redis 7 para caching y colas
  mailcatcher:# SMTP interceptador para desarrollo
```

### Uso

```powershell
# Iniciar todos los servicios
docker compose -f docker/docker-compose.yml up -d

# Iniciar solo PostgreSQL
docker compose -f docker/docker-compose.yml up -d postgres

# Ver logs
docker compose -f docker/docker-compose.yml logs -f

# Detener
docker compose -f docker/docker-compose.yml down
```

### Dockerfiles de Referencia

`docker/images/Dockerfile.node` — ejemplo de Dockerfile multi-stage para Node.js:

```
Stage 1 (deps):   Instalar dependencias con pnpm --frozen-lockfile
Stage 2 (build):  Compilar TypeScript
Stage 3 (runner): Solo copiar dist/ y node_modules, imagen final optimizada
```

---

## Integración con MCP Servers

El workspace soporta el **Model Context Protocol (MCP)** para que los agentes IA interactúen con sistemas externos de forma estandarizada.

### Estructura (`mcp/`)

```
mcp/
├── README.md                 # Documentación MCP
├── servers/                  # Definiciones de servidores MCP
│   ├── filesystem.json       # Servidor de archivos
│   └── ...                   # Más servidores (GitHub, DB, etc.)
└── tools/                    # Herramientas personalizadas
```

### Servidor Incluido

| Servidor | Descripción |
|----------|-------------|
| `filesystem` | Acceso seguro al sistema de archivos del workspace |

### Agregar un Servidor

```json
// mcp/servers/mi-servidor.json
{
  "name": "mi-servidor",
  "command": "node",
  "args": ["path/to/server.js"],
  "env": {
    "API_KEY": "${API_KEY}"
  }
}
```

---

## Integración con Clean Architecture

El workspace incluye una guía de Clean Architecture adaptada a Angular.

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

## Integración con Spec-Driven Development

El workspace promueve escribir especificaciones **antes** del código de implementación.

### Templates de Especificaciones

#### Feature Spec (`specs/templates/feature-spec.md`)

```markdown
# Feature Specification

## User Story
> As a <rol>, I want <objetivo> so that <beneficio>.

## Acceptance Criteria (BDD/Gherkin)
Scenario: <descripción>
  Given <precondición>
  When <acción>
  Then <resultado>

## Technical Notes
- Architecture impact:
- Database changes:
- API changes:

## Definition of Done
- [ ] Code complete with tests
- [ ] All acceptance criteria pass
- [ ] Linting passes
- [ ] PR reviewed and approved
```

#### Architecture Decision Record (`specs/templates/architecture-decision.md`)

Para decisiones técnicas significativas:

```
Context → Options Considered → Decision → Consequences → Related
```

### Flujo Spec-Driven

```
1. Escribir spec en specs/templates/feature-spec.md
2. Review de spec (usando prompt partial-spec-review.md)
3. Aprobación de spec
4. Implementación (usando prompt partial-implementation-plan.md)
5. Verificación contra acceptance criteria
6. Cierre
```

---

## Integración con Scrum y Agile

El workspace soporta Scrum/Agile a nivel de proyecto, con estructura para sprints, backlog y retrospectivas.

### Estructura por Proyecto

```
projects/<project>/
├── AGENTS.md              # Contexto épico del proyecto
├── specs/
│   ├── features/          # Historias de usuario
│   └── backlog/           # Backlog refinado
│       ├── icebox/        # Ideas sin refinar
│       └── refined/       # Listas para planning
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
2. **Durante el Sprint**: AI carga contexto del sprint → trabaja tareas en orden → logra progreso → corre tests
3. **Review/Retro**: AI resume completado → equipo revisa → retro capturada → mejoras aplicadas

---

## Automatizaciones y Scripts

| Script | Propósito | Uso |
|--------|-----------|-----|
| `scripts/project/new-project.ps1` | Scaffolding de nuevos proyectos desde template | `.\scripts\project\new-project.ps1 -Name "x" -Type "angular"` |
| `scripts/shared/setup-workspace.ps1` | Setup inicial del workspace (dirs, hooks, prereqs) | `.\scripts\shared\setup-workspace.ps1` |
| `scripts/utils/validate-rules.ps1` | Valida que todas las reglas cumplan el formato requerido | `.\scripts\utils\validate-rules.ps1` |
| `workflows/hooks/pre-commit.ps1` | Pre-commit hook: secret scanning + large file detection | Se instala automáticamente |
| `workflows/github/ci.yml` | CI pipeline reutilizable (lint → test → build) | Se copia a cada proyecto |

### new-project.ps1

```powershell
# Crear proyecto Angular
.\scripts\project\new-project.ps1 -Name "frontend-app" -Type "angular"

# (más tecnologías disponibles cuando se agreguen al workspace)

# Crear librería
.\scripts\project\new-project.ps1 -Name "shared-utils" -Type "library"
```

---

## Roadmap

### Phase 1: Foundation ✅ (Completado)

- [x] Diseño de estructura (arquitectura en 5 capas)
- [x] Reglas globales y políticas obligatorias
- [x] Reglas por tecnología (Angular, Spring Boot, Node.js, Rails)
- [x] Prompts reutilizables globales
- [x] Configuraciones compartidas (.editorconfig, .gitattributes, ESLint, Prettier)
- [x] Catálogo de proyectos y estructura de templates
- [x] Scripts de setup y git hooks
- [x] Docker Compose para servicios compartidos
- [x] Definiciones de servidores MCP
- [x] Documentación de arquitectura
- [x] Templates de Spec-Driven Development
- [x] Guía de Clean Architecture
- [x] Guía de Scrum/Agile
- [x] Primer ADR (ADR-001)

### Phase 2: Templates & Tooling (Siguiente)

- [ ] Template Angular completo (standalone + signals + Material)
- [ ] Template Spring Boot completo (hexagonal + JPA + Testcontainers)
- [ ] Template Node.js completo (NestJS + Prisma + Vitest)
- [ ] Template Rails completo (API-only + RSpec + Sidekiq)
- [ ] Template librería (TypeScript dual ESM/CJS)
- [ ] `new-project.ps1` funcional con todas las opciones
- [ ] Generador de configs IDE (VSCode, JetBrains)

### Phase 3: Knowledge & Automation

- [ ] Escaneo semanal de dependencias (Renovate)
- [ ] Búsqueda cross-project
- [ ] Indexación de knowledge-base para RAG
- [ ] Gestión automatizada de ADRs

### Phase 4: MCP & Agent Ecosystem

- [ ] Servidor MCP de GitHub (issues, PRs, actions)
- [ ] Tools MCP personalizadas (búsqueda de proyectos, validación de reglas)
- [ ] Skills para code review, testing, refactoring
- [ ] Orquestación multi-agente

### Phase 5: Scaling & Governance

- [ ] Integración con monorepos (Nx, Turborepo)
- [ ] Ciclo de vida de proyectos (crear → archivar → retirar)
- [ ] Permisos por rol para agentes
- [ ] Reglas de compliance (HIPAA, PCI-DSS, SOC2)

### Phase 6: Advanced AI Integration

- [ ] Pipeline RAG usando la knowledge base
- [ ] ADRs generados por AI
- [ ] Estimación predictiva de tareas
- [ ] Consultas en lenguaje natural ("qué está bloqueando el proyecto X?")

---

## Cómo Agregar una Nueva Tecnología

Agregar soporte para una nueva tecnología toma aproximadamente **5 minutos** y requiere crear 4 carpetas:

```powershell
# 1. Elegir key en kebab-case (ej: "flutter", "next-js", "fastapi")
$tech = "flutter"

# 2. Crear reglas
New-Item -ItemType Directory -Path "rules/$tech"
@"
# $tech Rules

## Architecture
...
"@ | Set-Content -Path "rules/$tech/AGENTS.md"

# 3. Crear prompts
New-Item -ItemType Directory -Path "prompts/$tech"

# 4. Crear configuraciones
New-Item -ItemType Directory -Path "config/$tech"

# 5. Crear template
New-Item -ItemType Directory -Path "templates/$tech"
@"
# $tech Project Template
...
"@ | Set-Content -Path "templates/$tech/AGENTS.md"

# 6. Registrar en el registro de tecnologías
# Editar docs/references/technologies.md

# 7. Validar
.\scripts\utils\validate-rules.ps1
```

### Plantilla para `rules/<tech>/AGENTS.md`

```markdown
# <Technology> Rules

## Architecture
- Patrón arquitectónico recomendado
- Convenciones de estructura de carpetas

## Conventions
- Naming de archivos, clases, funciones
- Estilo de código específico

## Testing
- Framework de testing preferido
- Estructura de tests y coverage

## Build & Tooling
- Sistema de build
- Package manager
- CLI commands recomendados

## Common Pitfalls
- Anti-patrones a evitar
- APIs deprecadas
- Tips de migración
```

---

## Cómo Agregar un Nuevo Proyecto

### Opción 1: Script Automatizado

```powershell
.\scripts\project\new-project.ps1 -Name "mi-proyecto" -Type "angular"
```

Esto crea `projects/mi-proyecto/` con:
- `AGENTS.md` con datos básicos del proyecto
- Subdirectorios `docs/`, `scripts/`, `rules/`, `specs/`
- Template files copiados desde `templates/angular/`
- Entrada añadida a `projects/PROJECTS_INDEX.md`

### Opción 2: Manual

```powershell
# 1. Copiar template
Copy-Item -Recurse projects/_template projects/mi-proyecto

# 2. Editar AGENTS.md
#    - Nombre del proyecto
#    - Descripción
#    - Tech stack
#    - Arquitectura
#    - Equipo y contactos
#    - Links (issue tracker, CI/CD, staging)

# 3. Agregar al índice
#    Editar projects/PROJECTS_INDEX.md
```

### Estructura Mínima de un Proyecto

```
projects/mi-proyecto/
├── AGENTS.md           # ← OBLIGATORIO: contexto para el agente AI
├── docs/               # Documentación del proyecto
├── specs/              # Especificaciones y ADRs del proyecto
├── rules/              # Reglas específicas (opcional)
└── prompts/            # Prompts específicos (opcional)
```

---

## Estrategia de Escalabilidad

### Para Decenas de Proyectos (1-50)

La estructura plana de `projects/<name>/` funciona sin modificaciones. El índice `PROJECTS_INDEX.md` proporciona visibilidad. Cada proyecto es independiente, no hay acoplamiento.

### Para Cientos de Proyectos (50-500)

```powershell
# Opcional: agrupar por dominio de negocio
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

```powershell
# Symlink a proyectos que viven fuera del workspace
New-Item -ItemType SymbolicLink -Path projects/external-api -Target C:\Projects\external-api

# O variable de entorno
$env:OPENCODE_WORKSPACE = "D:\Programación\AI-Developer-Workspace"
```

### Claves de Escalabilidad

1. **Sin acoplamiento**: Cada proyecto es una carpeta independiente. No hay registros centrales obligatorios.
2. **Sin duplicación**: Las reglas se heredan por capas. Un cambio en reglas globales afecta a todos los proyectos automáticamente.
3. **Descubrimiento predecible**: El orden de resolución de contexto es siempre el mismo, independientemente del número de proyectos.
4. **Bajo costo de entrada**: Agregar un proyecto = copiar template + editar AGENTS.md. No requiere configurar nada más.

---

## Estrategia de Mantenimiento

### Mantenimiento de Reglas

| Acción | Frecuencia | Responsable |
|--------|-----------|-------------|
| Revisar reglas globales | Trimestral | Arquitecto |
| Actualizar reglas de tecnología | Por major version | Tech Lead |
| Validar estructura de reglas | Cada PR | CI / validate-rules.ps1 |
| Archivar reglas obsoletas | Cuando se depreca una tecnología | Arquitecto |

### Mantenimiento de Prompts

- Los prompts se versionan junto con el workspace
- Se revisan cuando se identifica un patrón recurrente que merece un prompt
- Los prompts obsoletos se mueven a `prompts/_archive/`

### Mantenimiento de Knowledge Base

- **ADRs**: Se agregan cuando se toma una decisión arquitectónica significativa
- **Learnings**: Se actualizan continuamente (formato fecha + aprendizaje + tags)
- **Cheatsheets**: Se actualizan cuando cambian herramientas o comandos

### Validación Automática

```powershell
.\scripts\utils\validate-rules.ps1
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

Cada proyecto gestiona su propio versionado independientemente. Se recomienda:

- **Semantic Release** para librerías (versionado automático desde commits)
- **Git tags** con prefijo del proyecto: `mi-proyecto/v1.2.3`
- **CHANGELOG.md** en formato Keep a Changelog

### Versionado de ADRs

Los ADRs se numeran secuencialmente (ADR-001, ADR-002...). Cuando un ADR es supersedido, se actualiza su estado y se referencia al ADR que lo reemplaza.

### Commits Convencionales

Todos los commits siguen [Conventional Commits](https://www.conventionalcommits.org/):

```
feat(workspace): add FastAPI technology support
fix(scripts): resolve path issue in new-project.ps1
docs(readme): update MCP integration section
```

---

## Convenciones de Nomenclatura

| Elemento | Convención | Ejemplo |
|----------|-----------|---------|
| **Carpetas** | `kebab-case` | `knowledge-base`, `angular` |
| **Documentos** | `PascalCase.md` | `ARCHITECTURE.md`, `ROADMAP.md`, `ADR-001.md` |
| **Prompts parciales** | `partial-*.md` | `partial-code-review.md`, `partial-unit-test.md` |
| **Keys de tecnología** | `kebab-case` | `angular` (por ahora; se agregarán más luego) |
| **Nombres de proyecto** | `kebab-case` | `my-app`, `frontend-app` |
| **Nombres de script** | `kebab-case.ps1` | `new-project.ps1`, `setup-workspace.ps1` |
| **Archivos de reglas** | `AGENTS.md` | Siempre `AGENTS.md` (para descubrimiento automático) |
| **READMEs** | `README.md` | Solo para documentación de usuario |
| **Configuraciones** | `.prettierrc`, `.eslintrc.json` | Convención de la herramienta |
| **Archivos Docker** | `Dockerfile.<tech>` | `Dockerfile.node` |
| **Nombres de servicio Docker** | `kebab-case` | `docker-compose.yml` |
| **Archivos de workflow** | `*.yml` | `ci.yml`, `deploy.yml` |
| **Archivos de MCP** | `kebab-case.json` | `filesystem.json`, `github.json` |
| **Archivos de spec** | `kebab-case.md` | `feature-spec.md`, `architecture-decision.md` |
| **Extensiones** | Específicas del lenguaje | `.ts`, `.java`, `.rb`, `.py` |
| **Archivos de proyecto** | `AGENTS.md`, `PROJECTS_INDEX.md` | PascalCase para documentos de metadatos |

---

## Librerías y Herramientas Recomendadas

### Cross-Platform

| Herramienta | Propósito |
|-------------|-----------|
| **pnpm** | Package manager para JS/TS (más rápido que npm/yarn) |
| **Docker** | Contenedores para entornos estandarizados |
| **Make** | Task runner cross-platform |
| **CommitLint** | Validación de mensajes de commit |
| **EditorConfig** | Consistencia entre editores |
| **Prettier** | Formateo de código JS/TS/HTML/CSS |
| **Renovate** | Actualización automática de dependencias |
| **Snyk / Trivy** | Escaneo de seguridad |
| **Testcontainers** | Contenedores para tests de integración |

### Angular

Angular CDK, Angular Material, NgRx / SignalStore, RxJS, Tailwind CSS, Vitest + Testing Library, ESLint, Compodoc.

### Spring Boot

SpringDoc OpenAPI, MapStruct, Lombok, Flyway, Testcontainers, REST Assured, JaCoCo, Checkstyle / SpotBugs.

### Node.js

Express / Fastify / NestJS, Drizzle ORM / Prisma, Pino, Zod, Vitest, TSup / ESBuild, Husky + Lint-Staged.

### Ruby on Rails

Devise + Devise JWT, Pundit, Sidekiq, RSpec + FactoryBot, RuboCop, Alba / Blueprinter, Rswag.

---

## Integración con CI/CD

### GitHub Actions

El workspace incluye un workflow CI reutilizable en `workflows/github/ci.yml`:

```yaml
jobs:
  lint:    # Ejecutar linter
  test:    # Ejecutar tests (depende de lint)
  build:   # Compilar/build (depende de test)
```

Cada proyecto debe copiar este workflow y adaptarlo si es necesario.

### GitLab CI

Soporte para GitLab CI planificado (carpeta `workflows/gitlab/` lista para cuando se necesite).

---

## Licencia

Este workspace es un proyecto interno. Las licencias de los proyectos individuales pueden variar.

---

*AI Developer Workspace — Construido para agentes IA, diseñado por humanos.*
