# Project: Deprati

## Technology
- **Stack**: accelerator-sap-vue

---

## ⚠️ Dos variables de entorno

Este proyecto no tiene nada adentro. Todo está afuera, en dos rutas distintas:

| Variable | Qué contiene | Ejemplo |
|----------|-------------|---------|
| `$DEPRATI_BASE_PROJECT_PATH` | **SDD**: specs, reglas, documentación, ADRs | `$DEPRATI_BASE_PROJECT_PATH` |
| `$DEPRATI_PROJECT_PATH` | **Código real**: `app/`, `srv/`, `db/` | `$DEPRATI_PROJECT_PATH` |

---

## Flujo Exacto para el Agente

### Paso 1: Cargar contexto (en orden)
1. `rules/global/mandatory.md`
2. `rules/global/AGENTS.md`
3. Este archivo (declara **Technology: accelerator-sap-vue**)
4. `rules/accelerator-sap-vue/AGENTS.md`

### Paso 1.5: Sincronizar MCP servers externos
```bash
./scripts/mcp/sync.sh deprati
```
Lee los MCP servers de `$DEPRATI_BASE_PROJECT_PATH/.opencode/mcp/servers/` y los enlaza localmente.

### Paso 2: Validar y resolver rutas
```bash
code="${DEPRATI_PROJECT_PATH:-}"
base="${DEPRATI_BASE_PROJECT_PATH:-}"

# Primero validar que BASE existe siempre
if [ -z "$base" ] || [ ! -d "$base" ]; then
  echo "Se necesita DEPRATI_BASE_PROJECT_PATH apuntando a una carpeta existente" >&2
  exit 1
fi

# Si CODE no existe, usar BASE como fallback para todo
if [ -z "$code" ] || [ ! -d "$code" ]; then
  echo "DEPRATI_PROJECT_PATH no disponible. Usando DEPRATI_BASE_PROJECT_PATH para todo."
  code="$base"
fi
```

### Paso 3: Trabajar
| Acción | Dónde |
|--------|-------|
| Leer/escribir código | `$code` |
| Leer/escribir specs | `$base/specs/` |
| Leer/escribir ADRs | `$base/specs/` |
| Leer reglas extra | `$base/rules/` |
| Leer documentación | `$base/docs/` |
| Git | `$code` |

### Paso 4: Al terminar
- Código nuevo → `$code`
- Specs/ADRs nuevos → `$base/specs/`
- No dejar nada en `projects/deprati/`

---

## Convenciones de Código

### Frontend (Vue 3)
- Archivos: `PascalCase.vue` con `<script setup lang="ts">`
- Store: una store de Pinia por feature
- Routing: lazy loading, prefijo `dep-`
- Componentes compartidos: `App<Nombre>.vue`
- Props: `defineProps<{...}>()` con TypeScript
- Eventos: `defineEmits<{...}>()` tipado

### Backend (CAP)
- CDS models: `snake_case.cds`
- Servicios: `camelCase.js`, un archivo por feature
- Handlers: `on` (lógica), `before` (validación), `after` (enriquecer)
- Queries: `SELECT.from`, `INSERT.into`, `UPDATE.entity`, `DELETE.from`
- Errores: `req.reject(400, 'mensaje')` o `req.error({ code, message })`
- Async: siempre `await`, nunca `.then()`

### Commits
- Formato: `dep-<id>(<scope>): <desc>`
- Ejemplo: `dep-423(feature): add product catalog search`
- Scope: `feature`, `srv`, `db`, `ui`, `fix`, `config`

---

## Reglas de Calidad

- **TypeScript estricto**: sin `any`, sin `@ts-ignore`
- **No console.log** en commits → usar `req.log` o `cds.log`
- **No hardcodear** tenant IDs, destination names, ni URLs
- **Manejar errores SAP**: todo llamado externo con try/catch + fallback
- **CDS migrations**: nunca tocar la DB manualmente

---

## Prohibiciones

| Área | Regla |
|------|-------|
| `db/schema.cds` | No modificar sin aprobación del arquitecto de datos |
| `srv/external/` | No tocar integraciones con SAP ERP sin coordinación |
| Dependencias | No agregar sin pasar por el equipo |
| `manifest.yml` / `mta.yaml` | No tocar sin DevOps |

---

## SAP BTP

- **Destinations**: `${DEPRATI_BTP_DESTINATIONS}` (destinos internos definidos en variables de entorno)
- **IAS tenant**: `${DEPRATI_IAS_TENANT}`
- **API Gateway**: Cloud Foundry router con XSUAA

---

## Atajos

```bash
code="${DEPRATI_PROJECT_PATH}"
base="${DEPRATI_BASE_PROJECT_PATH}"

ls "$code/app/src/features/"   # Features frontend
ls "$code/srv/"                # Servicios CAP
ls "$base/specs/"              # Especificaciones SDD
```

---

## FAQ

**Q: ¿Falta una variable?**
R: Preguntale al usuario y sugerile que defina `$DEPRATI_PROJECT_PATH` y/o `$DEPRATI_BASE_PROJECT_PATH`.

**Q: ¿Dónde van los specs nuevos?**
R: En `$DEPRATI_BASE_PROJECT_PATH/specs/`.

**Q: ¿Dónde va el código nuevo?**
R: En `$DEPRATI_PROJECT_PATH`.


