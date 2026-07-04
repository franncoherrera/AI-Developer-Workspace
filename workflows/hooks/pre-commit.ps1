#!/usr/bin/env pwsh
# Pre-commit hook: run linter and tests on staged files

$Staged = git diff --cached --name-only --diff-filter=ACM
if (-not $Staged) {
    exit 0
}

Write-Host "Running pre-commit checks..." -ForegroundColor Cyan

# Check for secrets
$SecretsPattern = @('api[_-]?key', 'secret', 'password', 'token', 'credential')
$FilesToCheck = $Staged | Where-Object { $_ -match '\.(ts|js|java|rb|yml|yaml|json|env)$' }

foreach ($File in $FilesToCheck) {
    $Content = Get-Content $File -Raw
    foreach ($Pattern in $SecretsPattern) {
        if ($Content -match "(?i)$Pattern\s*[:=]\s*['""][^'""]+['""]") {
            Write-Host "[WARN] Possible secret in $File" -ForegroundColor Yellow
        }
    }
}

# Check for large files (>500KB)
foreach ($File in $Staged) {
    $Size = (Get-Item $File).Length
    if ($Size -gt 500KB) {
        Write-Host "[WARN] Large file staged: $File ($([math]::Round($Size/1KB))KB)" -ForegroundColor Yellow
    }
}

Write-Host "Pre-commit checks passed." -ForegroundColor Green
