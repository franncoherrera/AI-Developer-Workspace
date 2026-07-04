# Clean Architecture Pattern

## Layers (Inward Dependency)

```
Frameworks & Drivers (outer)
  ├── Web: Controllers, Middleware, Views
  ├── DB: Repositories, ORM, Migrations
  └── External: API clients, Message queues
        ↓
Interface Adapters
  ├── Presenters, DTOs, Mappers
  └── Controllers (transform input/output)
        ↓
Application (use cases)
  ├── Interactors / Services
  └── Ports (interfaces for outer layers)
        ↓
Domain (inner, no dependencies)
  ├── Entities / Aggregates
  ├── Value Objects
  └── Domain Events / Business Rules
```

## Key Rules

- Inner layers know nothing about outer layers
- Dependencies point inward (Dependency Inversion)
- Domain has zero framework imports
- Use cases orchestrate domain objects
- Infrastructure implements interfaces defined by application/domain

## Implementation per Tech

| Tech | Domain | Application | Infrastructure |
|------|--------|-------------|----------------|
| Angular | Types, Store | Services, Facades | HTTP repos, NgRx effects |
