# How to Add a New Technology

## Quick way (recommended)

```bash
./scripts/utils/register-technology.sh my-tech "My Tech"
```

Creates folders, copies rules template, registers in `technologies.json`.

Then:
1. Write `rules/<tech>/AGENTS.md`
2. Add prompts to `prompts/<tech>/`
3. Add configs to `config/<tech>/`
4. Update `technologies.json`: set `has.* = true`, `status = "active"`
5. Run `./scripts/utils/validate-rules.sh`

## Manual way

1. Create `rules/<tech>/AGENTS.md` (copy from `rules/_template/`)
2. Create `prompts/<tech>/`
3. Create `config/<tech>/`
4. Add entry to `docs/references/technologies.json`
5. Run `./scripts/utils/validate-rules.sh`
