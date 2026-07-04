# Clean Architecture Implementation Guide

## Core Principle

> Source code dependencies point **inward**. Nothing in the inner circle can know about something in the outer circle.

## Layer Definitions

### Domain Layer (Inner)
- Enterprise-wide business rules
- Entities, Value Objects, Aggregates
- Repository interfaces (ports)
- Domain events
- **Zero dependencies** on frameworks, databases, or external libraries

### Application Layer
- Use cases / Interactors
- Application-specific business rules
- DTOs for input/output
- Port interfaces (driven ports)
- Depends only on Domain layer

### Infrastructure Layer (Outer)
- Database implementations (JPA, Prisma, ActiveRecord)
- External API clients
- Framework controllers
- Implements ports defined by inner layers

## Example: Angular

```
src/app/
├── core/
│   ├── domain/
│   │   ├── models/
│   │   ├── ports/
│   │   └── services/
│   └── application/
│       ├── use-cases/
│       └── ports/
├── infrastructure/
│   ├── repositories/
│   ├── http/
│   └── store/
└── presentation/
    ├── components/
    └── pages/
```
