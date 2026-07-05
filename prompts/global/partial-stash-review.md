# Staged Changes Review Prompt

You are reviewing **staged changes** (changes added with `git add`, pending commit). The active project is at the `workdir` configured for the current agent.

1. **List staged files**: `git diff --cached --stat` to see what's staged
2. **Inspect changes**: `git diff --cached` to see the full diff
3. **Also check unstaged**: `git diff` to see if there are unstaged changes on the same files that might need to be included
4. **Analyze**: What files were changed, what problem does it solve, are there any issues?
5. **Categorize**:
   - **Completeness**: Is the change finished or work-in-progress?
   - **Correctness**: Edge cases, errors, logical issues
   - **Dependencies**: Does it need other changes to work?
   - **Safety**: Would committing this break anything?
6. **Visual test**: Si los cambios afectan la UI, levantá el proyecto (`npm run dev`, `cds watch`, etc.) y probalo con las herramientas `browser_*` — navegá a la URL, verificá que los cambios se vean bien, interactuá con la interfaz, tomá screenshots
7. **Recommendation**: Ready to commit, needs fixes, or missing changes
