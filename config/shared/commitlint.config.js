// CommitLint configuration
module.exports = {
  extends: ['@commitlint/config-conventional'],
  rules: {
    'type-enum': [2, 'always', [
      'feat', 'fix', 'refactor', 'test',
      'docs', 'chore', 'perf', 'style'
    ]],
    'scope-case': [2, 'always', 'kebab-case'],
    'subject-case': [2, 'never', ['sentence-case', 'start-case']],
    'subject-empty': [2, 'never'],
    'type-empty': [2, 'never'],
  },
};
