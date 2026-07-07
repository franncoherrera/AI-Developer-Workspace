# MCP (Model Context Protocol) Servers

## Estructura

```
mcp/
├── servers/       → Server definitions (formato workspace)
│   ├── browser.json
│   ├── filesystem.json
│   └── ext.*.json (symlinks a MCPs externos)
└── README.md
```

## Formato de server

Cada archivo en `mcp/servers/<name>.json`:

```json
{
  "name": "my-server",
  "command": "bash",
  "args": ["-c", "node \"$RUTA_PROYECTO/dist/server.js\""],
  "env": { "MY_VAR": "value" },
  "disabled": false
}
```

## Generar `opencode.jsonc`

OpenCode **no lee** directamente `mcp/servers/`. Los servers se convierten al formato estándar de OpenCode con:

```bash
./scripts/mcp/generate-config.sh
```

Esto genera `opencode.jsonc` en la raíz con los MCPs en el formato que OpenCode espera.

**Importante:** Reiniciar opencode después de regenerar.

## Sincronizar MCPs externos

```bash
./scripts/mcp/sync.sh deprati
```

Crea symlinks en `mcp/servers/ext.*.json` apuntando a los archivos del proyecto externo.
Luego ejecutar `generate-config.sh` para incluirlos en `opencode.jsonc`.

## Workflow

1. Editar o agregar archivos en `mcp/servers/`
2. `./scripts/mcp/generate-config.sh` (o `/f-mcp-sync` en opencode)
3. Reiniciar opencode
