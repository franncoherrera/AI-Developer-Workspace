# MCP (Model Context Protocol) Servers

This directory defines MCP servers available to AI agents operating in this workspace.

## Structure

```
mcp/
├── servers/            → MCP server configurations
│   └── <name>.json     → Server definition (command, args, env)
├── tools/              → Custom tool definitions
│   └── <name>.json     → Tool schema and implementation
└── README.md           → This file
```

## Adding a Server

Create `servers/<name>.json`:

```json
{
  "name": "my-server",
  "command": "node",
  "args": ["path/to/server.js"],
  "env": {
    "MY_VAR": "value"
  }
}
```

## Available Servers

| Server | Description | Status |
|--------|-------------|--------|
| _(add servers here)_ | | Planned |
