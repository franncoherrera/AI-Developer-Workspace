# Accelerator SAP + Vue.js Project Template

## Usage
```bash
scripts/project/new-project.ps1 -Name "my-fiori-app" -Type "accelerator-sap-vue"
```

## What You Get
- Vue 3 + Composition API + TypeScript (Vite)
- SAP CAP backend (Node.js) con CDS modeling
- Pinia stores + Vue Router
- Fundamental Library Styles o UI5 Web Components
- SAP Cloud SDK integrado
- XSUAA authentication setup
- Vitest + @sap/cds-test
- GitHub Actions CI/CD
- Docker Compose (CAP local + HANA express)
- `manifest.yml` y `mta.yaml` para BTP deploy

## Variants
- `accelerator-sap-vue/cap-node` — CAP con Node.js (default)
- `accelerator-sap-vue/cap-java` — CAP con Java
- `accelerator-sap-vue/ui5` — UI5 Web Components en vez de Fundamental Library

## Override Instructions
Edit `templates/accelerator-sap-vue/overrides.yml` to:
- Cambiar entre Fundamental Library y UI5 Web Components
- Usar CAP Java en vez de Node.js
- Deshabilitar multi-tenancy
- Cambiar provider de autenticación (IAS vs XSUAA)
