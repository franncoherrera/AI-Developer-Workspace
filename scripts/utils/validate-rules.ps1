#!/usr/bin/env pwsh
<#
.SYNOPSIS
    Validates that all rules files follow the required format and conventions.
#>

$WorkspaceRoot = Split-Path -Parent (Split-Path -Parent $PSScriptRoot)
$Issues = @()

# Check each rules directory has an AGENTS.md
$RulesDirs = Get-ChildItem (Join-Path $WorkspaceRoot "rules") -Directory
foreach ($Dir in $RulesDirs) {
    $AgentsFile = Join-Path $Dir.FullName "AGENTS.md"
    if (-not (Test-Path $AgentsFile)) {
        $Issues += "MISSING: $($Dir.Name)/AGENTS.md"
    }
}

# Check each technology rules has corresponding tech in registry
$ValidTechs = @("angular", "spring-boot", "node-js", "ruby-on-rails")
foreach ($Tech in $ValidTechs) {
    $TechRule = Join-Path $WorkspaceRoot "rules" $Tech "AGENTS.md"
    if (-not (Test-Path $TechRule)) {
        $Issues += "MISSING: rules/$Tech/AGENTS.md (registered in valid techs)"
    }
}

if ($Issues.Count -eq 0) {
    Write-Host "All rules valid." -ForegroundColor Green
    exit 0
} else {
    Write-Host "Found $($Issues.Count) issue(s):" -ForegroundColor Yellow
    $Issues | ForEach-Object { Write-Host "  - $_" -ForegroundColor Yellow }
    exit 1
}
