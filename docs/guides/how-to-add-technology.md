# How to Add a New Technology

## Quick way (recommended)

```powershell
.\scripts\utils\register-technology.ps1 -Key "my-tech" -Name "My Tech"
```

Creates folders, copies rules template, registers in `technologies.json`.

Then:
1. Write `rules/<tech>/AGENTS.md`
2. Add prompts to `prompts/<tech>/`
3. Add configs to `config/<tech>/`
4. Create template in `templates/<tech>/`
5. Update `technologies.json`: set `has.* = true`, `status = "active"`
6. Run `.\scripts\utils\validate-rules.ps1`

## Manual way

1. Create `rules/<tech>/AGENTS.md` (copy from `rules/_template/`)
2. Create `prompts/<tech>/`
3. Create `config/<tech>/`
4. Create `templates/<tech>/`
5. Add entry to `docs/references/technologies.json`
6. Run `.\scripts\utils\validate-rules.ps1`
