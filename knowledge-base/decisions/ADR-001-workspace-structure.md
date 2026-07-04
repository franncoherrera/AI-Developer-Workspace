# ADR-001: Workspace Structure Design

**Status**: Accepted
**Date**: 2026-07-04
**Author**: System Architect

## Context

We needed a workspace structure for AI-assisted development that:
- Supports multiple technologies (Angular, Spring Boot, Node.js, Rails)
- Scales to 100+ projects
- Minimizes rule/prompt duplication
- Is immediately understandable to any AI agent

## Decision

We chose a **layered, hierarchical structure** with five layers:
1. Global — rules/prompts/configs for everything
2. Technology — rules/prompts/configs per tech stack
3. Project — project-specific overrides
4. Sprint — iteration context
5. Task — atomic unit of work

Rules use stack-based inheritance: Global → Technology → Project.

## Consequences

### Positive
- Single source of truth for each concern
- Easy to add new technologies (create 4 folders)
- AI agents resolve context in predictable order

### Negative
- Requires discipline to put rules in correct layer
- Project-specific overrides can fragment if not reviewed
