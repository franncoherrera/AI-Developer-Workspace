# Pull Request Review Prompt

You are reviewing a **Pull Request**. The active project is at the `workdir` configured for the current agent.

1. **Fetch PR info**: Review the PR title, description, and linked issues
2. **Inspect diff**: Review the full diff of the PR
3. **Analyze**: What files were changed, what problem does it solve, are there any issues?
4. **Categorize**:
   - **Completeness**: Does the PR fully address the requirements?
   - **Correctness**: Edge cases, errors, logical issues
   - **Dependencies**: Does it need other changes to work?
   - **Safety**: Would merging this break anything?
5. **Recommendation**: Approve, request changes, or needs more context
