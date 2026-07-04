# Angular Project Template

## Usage
```bash
scripts/project/new-project.ps1 -Name "my-app" -Type "angular"
```

## What You Get
- Standalone components (no NgModules)
- Signals-based state management
- NgRx or SignalStore for global state
- Angular Material + CDK
- Tailwind CSS (or Angular Material theming)
- Vitest + Testing Library
- ESLint + Prettier
- Docker multi-stage build
- GitHub Actions CI/CD

## Override Instructions
Edit `templates/angular/overrides.yml` to:
- Disable SSR/SSG
- Use different CSS framework
- Remove state management
