# How to Add a New Technology

This guide explains how to add support for a new technology stack.

## Step-by-Step

### 1. Create Technology Key

Choose a kebab-case key: `flutter`, `next-js`, `fastapi`, `go-gin`

### 2. Create Technology Folders

```bash
# Rules
mkdir rules/<tech>/
echo "# <Tech> Rules" > rules/<tech>/AGENTS.md

# Prompts
mkdir prompts/<tech>/

# Configs
mkdir config/<tech>/

# Templates
mkdir templates/<tech>/
```

### 3. Write Rules

In `rules/<tech>/AGENTS.md`:
- Architecture conventions
- Code style specifics
- Testing framework and patterns
- Build and tooling
- Common pitfalls

### 4. Write Prompts

In `prompts/<tech>/`:
- Tech-specific code review prompts
- Tech-specific implementation prompts
- Migration/upgrade prompts

### 5. Create Template

In `templates/<tech>/`:
- Minimum viable project scaffold
- Best-practice configuration files
- Dockerfile if applicable
- CI/CD workflow template

### 6. Register Technology

Add to `docs/references/technologies.md`.

### 7. Validate

Run `scripts/utils/validate-rules.ps1` to ensure all required files exist.
