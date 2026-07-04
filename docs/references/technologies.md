# Technology Registry

> **Source of truth**: `docs/references/technologies.json`  
> This markdown file is a human-readable view. All scripts read from the JSON registry.

| Key | Name | Status | Rules | Prompts | Config | Template |
|-----|------|--------|-------|---------|--------|----------|
| `accelerator-sap-vue` | SAP CAP + Vue 3 | Active | ✅ | ✅ | ✅ | ✅ |

## Adding a Technology

```powershell
.\scripts\utils\register-technology.ps1 -Key "my-tech" -Name "My Tech"
```
