---
description: Regenera opencode.jsonc a partir de los archivos en mcp/servers/
---

# /f-mcp-sync

Ejecuta `scripts/mcp/generate-config.sh` para regenerar `opencode.jsonc` con los MCP servers definidos en `mcp/servers/*.json`.

## Uso

```
/f-mcp-sync
```

## Qué hace

1. Lee todos los archivos `mcp/servers/*.json`
2. Convierte cada uno al formato estándar de OpenCode (`type: "local"`, `command` como array, `enabled`, `environment`)
3. Genera/actualiza `opencode.jsonc` en la raíz del workspace
4. Hay que reiniciar opencode para que tome los cambios
