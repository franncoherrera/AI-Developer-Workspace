# MCP (Model Context Protocol) Servers

## Estructura

```
mcp/
├── servers/       → Server definitions (auto-detect via .opencode/settings.json)
│   ├── filesystem.json
│   └── ext.*.json (symlinks a MCPs externos)
├── tools/         → Custom tools
└── README.md
```

## Sincronizar MCPs externos

Los MCP servers que están en `$DEPRATI_BASE_PROJECT_PATH` se vinculan automáticamente:

```powershell
.\scripts\mcp\sync-external.ps1
```

Esto crea symlinks en `mcp/servers/ext.*.json` apuntando a los archivos originales.
El `auto_discover` de OpenCode los levanta sin copiar nada.

## Agregar un server local

Crear `servers/<name>.json`:

```json
{
  "name": "my-server",
  "command": "node",
  "args": ["path/to/server.js"],
  "env": { "MY_VAR": "value" }
}
```
