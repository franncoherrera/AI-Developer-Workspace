# Angular Rules

## Architecture

- Follow Standalone Components (no NgModules unless legacy).
- Use Signal-based state management (signals, computed, effect).
- Prefer `providedIn: 'root'` for singleton services.
- Lazy-load feature routes using `loadComponent`.

## Conventions

- Component files: `feature.component.ts`, `feature.component.html`
- Service files: `feature.service.ts`
- Type interfaces: `IFeatureData` in `feature.model.ts`
- Store: Feature-based NgRx stores with Signals integration

## Testing

- Use `TestBed` with `provideHttpClientTesting` for HTTP mocks.
- Prefer `harness`-based tests for Material/Angular CDK components.
- Test components via spectator or component harness, not raw fixture.

## RxJS

- Use `pipe` with explicit operators (no `.subscribe()` in services).
- Prefer `async` pipe or `toSignal` in templates.
- Destroy subscriptions via `takeUntilDestroyed()` or `DestroyRef`.

## CLI

- Generate with `ng generate` (not manual creation).
- Use `ng g @angular/core:standalone` for standalone migration.
