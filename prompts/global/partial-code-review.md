# Code Review Prompt

You are doing a code review. Focus on:

1. **Correctness**: Does the code do what it intends? Edge cases handled?
2. **Security**: Any injection risks, data leaks, auth bypasses?
3. **Performance**: N+1 queries, memory leaks, unnecessary re-renders?
4. **Maintainability**: Is the intent clear? Would another dev understand this in 6 months?
5. **Testing**: Are there tests? Do they cover the critical paths?

Format your response:
- **Critical** (must fix before merge)
- **Warning** (should fix, not blocking)
- **Suggestion** (nice to have)
