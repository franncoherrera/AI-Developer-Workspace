# Testing Standards (Global Partial)

## Coverage

- Minimum 80% line coverage for production code.
- 100% for critical paths (auth, payments, data validation).

## Test Structure

- Follow AAA pattern: Arrange, Act, Assert.
- One `describe` block per class/component.
- One `it` block per behavior.
- Descriptive test names: `it('should return 401 when token is expired')`.

## What to Test

- Business logic (unit tests)
- API contracts (integration tests)
- Critical user journeys (E2E)

## What NOT to Test

- Framework internals (Angular change detection, Spring DI, Rails ActiveRecord)
- Generated code
- Simple getters/setters
