# Code Standards (Global Partial)

Use these standards unless technology-specific rules differ.

## Naming

- Classes: `PascalCase`
- Functions/Methods: `camelCase`
- Constants/Enums: `UPPER_SNAKE_CASE`
- Files: `kebab-case` for configs and docs, `snake_case` for Ruby, `PascalCase` for components
- Folders: `kebab-case`

## Formatting

- Indentation: 2 spaces (JS/TS/Ruby), 4 spaces (Java)
- Max line length: 100 characters
- Semicolons: required (JS/TS), no semicolons (Ruby)
- Quotes: single quotes for JS/TS, double quotes for Java/Ruby

## Imports

- Group: built-in → external → internal
- Sort alphabetically within groups
- No unused imports (treat as error)
