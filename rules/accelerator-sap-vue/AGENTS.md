# Accelerator SAP + Vue.js Rules

## Reglas Básicas (siempre aplicar)

| Regla | Descripción |
|-------|-------------|
| **Vue 3 + Composition API** | Todo componente nuevo con `<script setup lang="ts">`. Nada de Options API. |
| **CAP handlers** | Usar `await` siempre. Handlers: `on` (lógica), `before` (validación), `after` (enriquecer). |
| **CDS models** | Definir entidades en `db/schema.cds`. Relaciones con `associations`. No SQL directo. |
| **OData v4** | Siempre respetar `$filter`, `$expand`, `$select`. No inventar endpoints custom. |
| **Pinia** | Una store por feature. Actions asíncronas con `await`. Nunca mutar estado fuera de actions. |
| **XSUAA** | No hardcodear tokens. Usar `@sap/xssec` o `req.user` en CAP. |
| **SAP Fiori** | Seguir Fiori Design Guidelines. Usar Fundamental Library o UI5 Web Components. |
| **Tests** | Unit: Vitest (frontend). Integration: `@sap/cds-test` (backend). Mocks con `axios-mock-adapter`. |
| **Errores** | CAP: `req.reject(code, message)`. Frontend: try/catch + notificación Fiori. |
| **Async** | Siempre `await`. Nunca `.then()`. Nunca callbacks en handlers. |

## Architecture

- **Frontend**: Vue 3 + Composition API + TypeScript (Vite como build tool)
- **Backend**: SAP CAP (Cloud Application Programming) con Node.js o Java
- **Base de datos**: SAP HANA Cloud (CDS entities para modelado)
- **Autenticación**: SAP BTP — XSUAA / IAS (Identity Authentication Service)
- **API**: OData v4 (expuesto por CAP server)
- **UI/UX**: SAP Fiori Design Guidelines + Fundamental Library Styles
- **Deploy**: SAP BTP Cloud Foundry o Kyma (Kubernetes)
- **Testing**: Vitest (frontend) + Jest / supertest (CAP backend)

## Conventions

- Componentes Vue: `PascalCase.vue` con `<script setup lang="ts">`
- CDS models: `snake_case.cds` (convención SAP)
- Servicios CAP: `camelCase` en JavaScript/TypeScript
- Archivos de test: `*.test.ts` junto al archivo que testea
- State management: Pinia (stores modulares)
- Llamadas a SAP: usar `@sap-cloud-sdk/*` para APIs REST/OData
- Manejo de errores: interceptors en Axios para SAP BTP error codes

## CAP (Cloud Application Programming)

- Modelar entidades en `db/schema.cds` con anotaciones Fiori
- Servicios en `srv/` con handlers `on`, `before`, `after`
- Usar `@sap/cds` para queries tipadas y hooks de validación
- Eventos asíncronos con `cds.context` y `cds.emit`
- Migraciones: CDS deploy automático (no usar Flyway/Liquibase)
- Proyecto estructurado por features (no por capas técnicas)

## Key Libraries

| Library | Purpose |
|---------|---------|
| `@sap/cds` | CAP framework core |
| `@sap-cloud-sdk/core` | SAP Cloud SDK (calls a APIs SAP) |
| `@sap/xssec` | Seguridad XSUAA |
| `vue-router` 4 | Routing |
| `pinia` | State management |
| `fundamental-vue` / `@ui5/webcomponents` | Fiori UI components |
| `@vitejs/plugin-vue` | Vite build |
| `axios` | HTTP client (con interceptors SAP) |
| `vitest` | Unit testing |
| `@sap/cds-test` | CAP integration testing |
| `@ui5/cli` | UI5 toolchain utilities |

## Testing

- **Unit (frontend)**: Vitest + Vue Test Utils + Pinia testing
- **Integration (CAP)**: `@sap/cds-test` para probar handlers OData
- **E2E**: Playwright o Cypress con simulación de login XSUAA
- Mocks: `axios-mock-adapter` para llamadas a servicios SAP externos
- Test data: fixtures JSON en `test/fixtures/`

## Project Structure

```
app/                     → Vue.js frontend
├── src/
│   ├── components/      → Componentes globales
│   ├── features/        → Feature modules (router, store, components)
│   ├── composables/     → Composition API hooks
│   ├── services/        → CAP OData clients (axios)
│   ├── router/          → Vue Router config
│   ├── stores/          → Pinia stores
│   └── utils/           → Helpers, formatters, SAP utils
├── public/
├── tests/
└── vite.config.ts

srv/                     → CAP backend services
├── <feature>/
│   ├── <feature>.js     → Service handlers
│   └── <feature>.test.js
└── server.js            → CAP server entry

db/                      → CDS data models
├── schema.cds           → Entidades y relaciones
└── data/                → Seed data (.csv)

test/                    → CAP integration tests
└── integration/
```

## SAP BTP Deployment

- Manifest: `manifest.yml` para Cloud Foundry
- MTA: `mta.yaml` con módulos app + srv + db + destination
- Environment variables via `xs-env.json` o `mta.yaml` parameters
- Destinations: configurar en BTP cockpit para APIs externas
- CI/CD: SAP CI/CD Service o GitHub Actions con Cloud Foundry CLI
- Multi-tenancy: extensibilidad vía `@sap/cds-mtxs`

## Common Pitfalls

- No hardcodear tenant IDs ni destination names
- No usar `require` directo a módulos SAP sin manejo de errores
- CORS: configurar en `package.json` del CAP server (`cds.requires.cors`)
- OData: respetar convenciones de filtrado (`$filter`, `$expand`, `$select`)
- No mezclar CAP handlers síncronos con promesas sin `await`
- Evitar queries N+1: usar `expand` en CDS associations
