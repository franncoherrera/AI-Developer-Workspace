# ECC-Universal Skills Reference

Lista completa de las **261 skills** de [ecc-universal](https://github.com/affaan-m/ECC) v2.0.0.

---

## Contenido

- [Workflow & Metodologías](#workflow--metodologías)
- [Frontend](#frontend)
- [Backend & API](#backend--api)
- [Lenguajes & Frameworks](#lenguajes--frameworks)
- [Base de Datos](#base-de-datos)
- [Testing](#testing)
- [DevOps & Deployment](#devops--deployment)
- [Seguridad](#seguridad)
- [AI / ML / LLM](#ai--ml--llm)
- [Blockchain / Web3](#blockchain--web3)
- [Agentes & Automación](#agentes--automación)
- [Infraestructura & Networking](#infraestructura--networking)
- [Contenido & Marketing](#contenido--marketing)
- [Domain / Negocio](#domain--negocio)
- [Mobile](#mobile)
- [Video & Media](#video--media)
- [Design Systems & UI](#design-systems--ui)
- [Utilidades & Generales](#utilidades--generales)

---

## Workflow & Metodologías

| Skill | Descripción |
|-------|-------------|
| **tdd-workflow** | Test-driven development con 80%+ coverage (unit, integration, E2E). |
| **verification-loop** | Verification system para Claude Code: build, types, lint, tests, security. |
| **eval-harness** | Formal evaluation framework con pass@k y eval-driven development. |
| **coding-standards** | Baseline cross-project coding conventions (naming, inmutabilidad, DRY, KISS). |
| **error-handling** | Patrones de error handling para TypeScript, Python y Go. |
| **code-tour** | Crear CodeTour `.tour` files para onboarding y walkthroughs. |
| **search-first** | Research-before-coding: buscar tools/libraries/patterns antes de escribir. |
| **agentic-engineering** | Eval-first execution, decomposition y cost-aware model routing. |
| **ai-first-engineering** | Operating model para equipos donde AI agents generan la mayor parte del código. |

## Frontend

| Skill | Descripción |
|-------|-------------|
| **frontend-patterns** | Patrones React, Next.js, state management, performance optimization. |
| **frontend-design-direction** | Define design direction para producción UI work. |
| **react-patterns** | React 18/19: hooks, server/client components, Suspense, error boundaries, form actions. |
| **react-performance** | Performance optimization para React/Next.js (70+ rules, 8 categories). |
| **react-testing** | Component testing con RTL, Vitest/Jest, MSW, axe. |
| **motion-ui** | UI motion system para React/Next.js con animaciones y transiciones. |
| **make-interfaces-feel-better** | Spacing, typography, borders, shadows, motion, hit areas, icons. |
| **angular-developer** | Genera Angular code: signals, forms, DI, routing, SSR, accessibility. |
| **dart-flutter-patterns** | Dart/Flutter: null safety, immutable state, BLoC, Riverpod, GoRouter. |
| **compose-multiplatform-patterns** | Jetpack Compose para KMP: state, navigation, theming, performance. |
| **liquid-glass-design** | iOS 26 Liquid Glass design system: blur, reflection, morphing. |
| **frontend-slides** | HTML presentations animadas, convierte PowerPoint a web. |
| **ui-demo** | Graba polished UI demo videos con Playwright. |
| **ui-to-vue** | Batch conversión de screenshots a Vue 3 components (Vant, Element Plus). |

## Backend & API

| Skill | Descripción |
|-------|-------------|
| **backend-patterns** | Backend architecture: API design, database optimization, caching, middleware. |
| **api-design** | REST API: resource naming, status codes, pagination, versioning, rate limiting. |
| **mcp-server-patterns** | Build MCP servers con Node/TypeScript SDK. |
| **api-connector-builder** | Build API connectors matching existing repo integration patterns. |
| **search-first** | Research-before-coding workflow. |

## Lenguajes & Frameworks

### TypeScript / JavaScript / Node.js

| Skill | Descripción |
|-------|-------------|
| **nodejs-keccak256** | Previene Ethereum hashing bugs (sha3-256 != Keccak-256). |
| **nestjs-patterns** | NestJS: modules, controllers, providers, guards, interceptors. |
| **prisma-patterns** | Prisma ORM: schema design, query optimization, transactions, traps. |

### Python

| Skill | Descripción |
|-------|-------------|
| **python-patterns** | Python idioms, PEP 8, type hints, best practices. |
| **python-testing** | pytest, TDD, fixtures, mocking, parametrization, coverage. |
| **django-patterns** | Django: REST APIs con DRF, ORM, caching, signals, middleware. |
| **django-security** | Django: auth, CSRF, XSS, SQLi, secure deployment. |
| **django-tdd** | Django: pytest-django, factory_boy, mocking, coverage. |
| **django-verification** | Verification loop para Django: migrations, lint, tests, security. |
| **fastapi-patterns** | FastAPI: Pydantic v2, dependency injection, async, testing. |

### Java & JVM

| Skill | Descripción |
|-------|-------------|
| **java-coding-standards** | Java standards: naming, immutability, Optional, streams, CDI. |
| **springboot-patterns** | Spring Boot: REST, layered services, caching, async. |
| **springboot-security** | Spring Security: authn/authz, validation, CSRF, rate limiting. |
| **springboot-tdd** | Spring Boot: JUnit 5, Mockito, MockMvc, Testcontainers, JaCoCo. |
| **springboot-verification** | Verification loop para Spring Boot: build, static analysis, security. |
| **jpa-patterns** | JPA/Hibernate: entity design, relationships, query optimization. |
| **quarkus-patterns** | Quarkus 3.x LTS con Camel, RESTful, CDI, Panache. |
| **quarkus-security** | Quarkus Security: JWT/OIDC, RBAC, CSRF, secrets. |
| **quarkus-tdd** | Quarkus: JUnit 5, Mockito, REST Assured, Camel testing. |
| **quarkus-verification** | Verification loop para Quarkus: build, native compilation, security. |

### Kotlin

| Skill | Descripción |
|-------|-------------|
| **kotlin-patterns** | Idiomatic Kotlin: coroutines, null safety, DSL builders. |
| **kotlin-testing** | Kotlin: Kotest, MockK, coroutine testing, Kover. |
| **kotlin-coroutines-flows** | Coroutines Flow: StateFlow, error handling, testing. |
| **kotlin-ktor-patterns** | Ktor: routing, plugins, auth, Koin DI, WebSockets. |
| **kotlin-exposed-patterns** | JetBrains Exposed ORM: DSL, DAO, Flyway, HikariCP. |

### Go

| Skill | Descripción |
|-------|-------------|
| **golang-patterns** | Idiomatic Go: best practices, conventions. |
| **golang-testing** | Go: table-driven tests, benchmarks, fuzzing, coverage. |

### Rust

| Skill | Descripción |
|-------|-------------|
| **rust-patterns** | Idiomatic Rust: ownership, error handling, traits, concurrency. |
| **rust-testing** | Rust: unit, integration, async, property-based, mocking. |

### C++

| Skill | Descripción |
|-------|-------------|
| **cpp-coding-standards** | C++ Core Guidelines: modern, safe, idiomatic. |
| **cpp-testing** | C++: GoogleTest, CTest, sanitizers. |

### C#

| Skill | Descripción |
|-------|-------------|
| **dotnet-patterns** | C# / .NET: dependency injection, async/await, conventions. |
| **csharp-testing** | C#: xUnit, FluentAssertions, mocking, integration tests. |

### F#

| Skill | Descripción |
|-------|-------------|
| **fsharp-testing** | F#: xUnit, FsUnit, Unquote, FsCheck. |

### Swift

| Skill | Descripción |
|-------|-------------|
| **swiftui-patterns** | SwiftUI: @Observable, view composition, navigation, performance. |
| **swift-concurrency-6-2** | Swift 6.2: single-threaded by default, @concurrent. |
| **swift-actor-persistence** | Thread-safe data persistence con actors. |
| **swift-protocol-di-testing** | Protocol-based DI para Swift testing. |

### Perl

| Skill | Descripción |
|-------|-------------|
| **perl-patterns** | Modern Perl 5.36+: idioms, best practices. |
| **perl-security** | Perl: taint mode, input validation, DBI parameterized queries. |
| **perl-testing** | Perl: Test2::V0, prove, Devel::Cover. |

### PHP / Laravel

| Skill | Descripción |
|-------|-------------|
| **laravel-patterns** | Laravel: Eloquent, service layers, queues, events, caching. |
| **laravel-security** | Laravel: auth, Eloquent safety, CSRF, XSS, deployment. |
| **laravel-tdd** | Laravel: PHPUnit, Pest, HTTP tests, Sanctum. |
| **laravel-verification** | Verification loop para Laravel: env, lint, static analysis, security. |
| **laravel-plugin-discovery** | Descubrir/evaluar Laravel packages via LaraPlugins.io. |

## Base de Datos

| Skill | Descripción |
|-------|-------------|
| **postgres-patterns** | PostgreSQL: query optimization, schema design, indexing, security. |
| **mysql-patterns** | MySQL/MariaDB: schema, query, indexing, replication. |
| **clickhouse-io** | ClickHouse: query optimization, analytics, data engineering. |
| **database-migrations** | DB migrations: schema changes, rollbacks, zero-downtime (Prisma, Drizzle, Django, etc.). |

## Testing

| Skill | Descripción |
|-------|-------------|
| **e2e-testing** | Playwright: Page Object Model, CI/CD, flaky test strategies. |
| **ai-regression-testing** | Regression testing para AI-assisted development. |
| **windows-desktop-e2e** | E2E para Windows native apps (WPF, WinForms) con pywinauto. |
| *(ver también testing skills por lenguaje arriba)* | |

## DevOps & Deployment

| Skill | Descripción |
|-------|-------------|
| **deployment-patterns** | CI/CD, Docker, health checks, rollback strategies. |
| **docker-patterns** | Docker Compose, container security, networking, volumes. |
| **production-audit** | Production readiness audit para shipped apps. |
| **benchmark-optimization-loop** | Benchmark latency/throughput/cost, recursive optimization. |
| **parallel-execution-optimizer** | Parallel work, concurrent agents, batched tool calls. |
| **latency-critical-systems** | Realtime dashboards, market data, streaming, HFT. |
| **data-throughput-accelerator** | Acelerar data ingestion, backfill, ETL, warehouse. |

## Seguridad

| Skill | Descripción |
|-------|-------------|
| **security-review** | OWASP, secrets, input validation, SQLi, XSS, CSRF, rate limiting. |
| **security-scan** | Scanear configuración Claude Code con AgentShield. |
| **security-bounty-hunter** | Hunt for bounty-worthy security issues en repos. |
| **healthcare-phi-compliance** | PHI/PII compliance: data classification, access control, audit trails. |
| **hipaa-compliance** | HIPAA: covered entities, BAAs, breach posture. |
| *(ver también security skills por framework/lenguaje arriba)* | |

## AI / ML / LLM

| Skill | Descripción |
|-------|-------------|
| **mle-workflow** | ML engineering: data contracts, training, evaluation, monitoring. |
| **deep-research** | Multi-source research con firecrawl y exa MCPs. |
| **iterative-retrieval** | Progressive context retrieval para subagent context. |
| **cost-aware-llm-pipeline** | Cost optimization: model routing, budget tracking, prompt caching. |
| **foundation-models-on-device** | Apple FoundationModels: on-device LLM en iOS 26+. |
| **exa-search** | Neural search via Exa MCP. |
| **fal-ai-media** | Media generation: image, video, audio via fal.ai. |
| **benchmark-optimization-loop** | Recursive optimization, benchmark latency/throughput. |
| **prompt-optimizer** | Optimización de prompts. |

## Blockchain / Web3

| Skill | Descripción |
|-------|-------------|
| **defi-amm-security** | Solidity AMM security: reentrancy, CEI, oracle manipulation. |
| **evm-token-decimals** | Prevenir decimal mismatch bugs en EVM chains. |
| **nodejs-keccak256** | Ethereum hashing: Keccak-256 != SHA3-256. |
| **llm-trading-agent-security** | Security para autonomous trading agents con wallet authority. |

## Agentes & Automación

| Skill | Descripción |
|-------|-------------|
| **agentic-os** | Multi-agent operating systems: kernel, specialist agents, file-based memory. |
| **agent-architecture-audit** | 12-layer agent stack audit: wrapper regression, memory pollution, tool discipline. |
| **claude-devfleet** | Multi-agent coding via worktrees, parallel agents, structured reports. |
| **autonomous-loops** | Autonomous Claude Code loops: sequential pipelines a DAG systems. |
| **continuous-agent-loop** | Continuous loops con quality gates, evals, recovery. |
| **agent-harness-construction** | Diseñar action spaces, tool definitions, observation formatting. |
| **dmux-workflows** | Multi-agent orchestration con dmux (tmux pane manager). |
| **team-agent-orchestration** | Agent squads con work items, Kanban, merge gates, handoffs. |
| **team-builder** | Interactive agent picker para equipos paralelos. |
| **ralphinho-rfc-pipeline** | RFC-driven multi-agent DAG con quality gates. |
| **council** | Four-voice council para decisiones ambiguas. |
| **agent-sort** | Build ECC install plan: DAILY vs LIBRARY buckets. |
| **workspace-surface-audit** | Auditar repo, MCP servers, plugins, recomendar setup. |
| **agent-introspection-debugging** | Self-debugging workflow para AI agent failures. |
| **enterprise-agent-ops** | Long-lived agent workloads con observability. |
| **recursive-decision-ledger** | Rollouts, decision processes, stochastic optimization. |

## Infraestructura & Networking

| Skill | Descripción |
|-------|-------------|
| **cisco-ios-patterns** | Cisco IOS/IOS-XE: show commands, ACL placement, interface hygiene. |
| **network-bgp-diagnostics** | BGP troubleshooting: neighbor state, route exchange, AS path. |
| **network-config-validation** | Pre-deployment checks: dangerous commands, subnet overlaps. |
| **network-interface-health** | Interface errors, CRCs, duplex mismatches, flapping. |
| **netmiko-ssh-automation** | Python Netmiko: read-only collection, TextFSM, guarded config. |
| **homelab-network-readiness** | VLAN segmentation, DNS filtering, WireGuard. |
| **homelab-network-setup** | Gateways, switches, DHCP, DNS, cabling. |

## Contenido & Marketing

| Skill | Descripción |
|-------|-------------|
| **article-writing** | Artículos, guides, blog posts, newsletters en voice consistente. |
| **brand-voice** | Source-derived writing style profile para contenido y outreach. |
| **content-engine** | Platform-native content: X, LinkedIn, TikTok, YouTube, newsletters. |
| **crosspost** | Multi-platform distribution (X, LinkedIn, Threads, Bluesky). |
| **seo** | SEO: technical, on-page, structured data, Core Web Vitals, content. |
| **investor-materials** | Pitch decks, one-pagers, memos, financial models. |
| **investor-outreach** | Cold emails, warm intros, follow-ups para fundraising. |
| **market-research** | Market sizing, competitive analysis, investor due diligence. |
| **lead-intelligence** | Lead scoring, warm path discovery, outreach (email, LinkedIn, X). |
| **connections-optimizer** | X/LinkedIn network pruning, add recommendations, warm outreach. |
| **social-graph-ranker** | Weighted graph ranking para warm intro discovery. |
| **data-scraper-agent** | Automated data collection: jobs, prices, news, GitHub, sports. |

## Domain / Negocio

| Skill | Descripción |
|-------|-------------|
| **customer-billing-ops** | Subscriptions, refunds, churn, billing-portal recovery (Stripe). |
| **finance-billing-ops** | Revenue, pricing, refunds, billing-model analysis. |
| **carrier-relationship-management** | Gestión de relaciones con carriers. |
| **customs-trade-compliance** | Cumplimiento aduanero y comercio internacional. |
| **energy-procurement** | Procura de energía. |
| **inventory-demand-planning** | Planificación de demanda e inventario. |
| **logistics-exception-management** | Gestión de excepciones logísticas. |
| **production-scheduling** | Scheduling de producción. |
| **quality-nonconformance** | Gestión de no conformidades de calidad. |
| **returns-reverse-logistics** | Logística inversa y devoluciones. |
| **jira-integration** | Jira: tickets, requirements, status, comments via MCP/REST. |
| **project-flow-ops** | GitHub + Linear: backlog, PR triage, GitHub-to-Linear coordination. |
| **github-ops** | GitHub: issues, PRs, CI/CD, releases, stale items. |
| **product-capability** | PRD-to-SRS: constraints, invariants, interfaces before multi-service work. |
| **knowledge-ops** | Knowledge base management, ingestion, sync, retrieval. |

## Mobile

| Skill | Descripción |
|-------|-------------|
| **android-clean-architecture** | Clean Architecture para Android/KMP: UseCases, Repositories. |
| **compose-multiplatform-patterns** | Compose Multiplatform: state, navigation, theming, performance. |
| **dart-flutter-patterns** | Flutter: null safety, BLoC, Riverpod, GoRouter. |
| **swiftui-patterns** | SwiftUI: @Observable, navigation, performance. |
| **swift-concurrency-6-2** | Swift 6.2 concurrency. |

## Video & Media

| Skill | Descripción |
|-------|-------------|
| **videodb** | See/Understand/Act on video: ingest, index, search, transcode. |
| **video-editing** | AI-assisted editing: FFmpeg, Remotion, ElevenLabs, fal.ai, CapCut. |
| **manim-video** | Build animated explainers con Manim. |
| **remotion-video-creation** | Video creation in React con Remotion (29 rules: 3D, audio, captions, etc.). |
| **ui-demo** | Record UI demo videos con Playwright. |

## Design Systems & UI

| Skill | Descripción |
|-------|-------------|
| **liquid-glass-design** | iOS 26 Liquid Glass: blur, reflection, interactive morphing. |
| **motion-ui** | Production-ready UI motion para React/Next.js. |
| **frontend-design-direction** | Define ECC-specific design direction para UI work. |
| **make-interfaces-feel-better** | Spacing, typography, shadows, motion, interaction states. |
| **blender-motion-state-inspection** | Inspeccionar characters, rigs, poses, retargeting en Blender. |

## Utilidades & Generales

| Skill | Descripción |
|-------|-------------|
| **strategic-compact** | Sugiere `/compact` en momentos estratégicos para preservar contexto. |
| **config-ecc** | Interactive installer para ECC skills y rules. |
| **skill-scout** | Search skills locales, marketplace, GitHub antes de crear una nueva. |
| **skill-stocktake** | Auditar skills y commands: Quick Scan o Full Stocktake. |
| **hookify-rules** | Crear hookify rules y configurar hookify. |
| **continuous-learning** | [DEPRECATED] Legacy v1. Usar continuous-learning-v2. |
| **continuous-learning-v2** | Instinct-based learning: observa sesiones, crea instincts con confidence. |
| **cost-tracking** | Trackear token usage, spending, budgets de Claude Code. |
| **ecc-tools-cost-audit** | Auditar costos de ECC Tools: PR creation, quota bypass, bill spikes. |
| **terminal-ops** | Evidence-first repo execution: run, verify, fix. |
| **research-ops** | Evidence-first current-state research workflow. |
| **email-ops** | Evidence-first mailbox triage, drafting, send verification. |
| **messages-ops** | Evidence-first live messaging: texts, DMs, one-time codes. |
| **unified-notifications-ops** | Notifications: GitHub, Linear, desktop alerts, hooks. |
| **google-workspace-ops** | Drive, Docs, Sheets, Slides como un workflow surface. |
| **scientific-pkg-gget** | Genomic database queries, sequence lookup, BLAST. |
| **scientific-db-pubmed-database** | PubMed/NCBI E-utilities: biomedical literature search. |
| **scientific-db-uspto-database** | USPTO patent/trademark search, PatentSearch, TSDR. |
| **scientific-thinking-literature-review** | Systematic literature review: search planning, synthesis. |
| **scientific-thinking-scholar-evaluation** | Structured scholarly-work evaluation. |
| **content-hash-cache-pattern** | Cachear file processing con SHA-256 content hashes. |
| **regex-vs-llm-structured-text** | Decidir entre regex y LLM para parsing structured text. |
| **nutrient-document-processing** | Process PDFs, DOCX, XLSX, PPTX, HTML, images (OCR, redact, sign). |
| **visa-doc-translate** | Traducir documentos de visa a inglés, crear PDF bilingüe. |
| **token-budget-advisor** | Advisory sobre budget de tokens. |
| **plankton-code-quality** | Write-time code quality con auto-formatting, linting. |
| **automation-audit-ops** | Automation inventory y overlap audit. |
| **dynamic-workflow-mode** | Task-local harnesses, eval gates, reusable skill extraction. |
| **dashboard-builder** | Build monitoring dashboards (Grafana, SigNoz). |
| **nanoclaw-repl** | Operar y extender NanoClaw v2 REPL. |
| **blueprint** | Blueprint system. |

---

*Referencia generada de ecc-universal v2.0.0 — 261 skills.*

*Repo oficial: [github.com/affaan-m/ECC](https://github.com/affaan-m/ECC)*
