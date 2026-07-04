#!/usr/bin/env pwsh
<#
.SYNOPSIS
    Validates workspace integrity: rules, registry, and folder structure.
#>

function Join-Paths([string]$Root, [string[]]$Parts) {
    $result = $Root
    foreach ($part in $Parts) {
        $result = Join-Path $result $part
    }
    return $result
}

$WorkspaceRoot = Split-Path -Parent (Split-Path -Parent $PSScriptRoot)
$RegistryPath = Join-Paths $WorkspaceRoot @("docs", "references", "technologies.json")
$Issues = @()

# Non-tech folders to exclude from orphan check
$NonTechFolders = @("_template", "_common", "shared", "ide", "global", "code-review", "testing")

# Load registry
if (-not (Test-Path $RegistryPath)) {
    Write-Error "Registry not found: $RegistryPath"
    exit 1
}

$Registry = Get-Content $RegistryPath -Raw | ConvertFrom-Json

# Check each rules directory has an AGENTS.md
$RulesDir = Join-Path $WorkspaceRoot "rules"
$RulesDirs = Get-ChildItem $RulesDir -Directory
foreach ($Dir in $RulesDirs) {
    $AgentsFile = Join-Path $Dir.FullName "AGENTS.md"
    if (-not (Test-Path $AgentsFile)) {
        $Issues += "MISSING: rules/$($Dir.Name)/AGENTS.md"
    }
}

# Check each registered technology has required folders
foreach ($Tech in $Registry.technologies) {
    $Key = $Tech.key

    # Rules are always mandatory
    $RulePath = Join-Paths $WorkspaceRoot @("rules", $Key, "AGENTS.md")
    if (-not (Test-Path $RulePath)) {
        $Issues += "MISSING: rules/$Key/AGENTS.md (registered in technologies.json)"
    }

    $TechRules = Join-Paths $WorkspaceRoot @("rules", $Key)
    if ($Tech.has.rules -and -not (Test-Path $TechRules)) {
        $Issues += "MISSING: rules/$Key/ (declared in registry)"
    }
    $TechPrompts = Join-Paths $WorkspaceRoot @("prompts", $Key)
    if ($Tech.has.prompts -and -not (Test-Path $TechPrompts)) {
        $Issues += "MISSING: prompts/$Key/ (declared in registry)"
    }
    $TechConfig = Join-Paths $WorkspaceRoot @("config", $Key)
    if ($Tech.has.config -and -not (Test-Path $TechConfig)) {
        $Issues += "MISSING: config/$Key/ (declared in registry)"
    }
    $TechTemplate = Join-Paths $WorkspaceRoot @("templates", $Key)
    if ($Tech.has.template -and -not (Test-Path $TechTemplate)) {
        $Issues += "MISSING: templates/$Key/ (declared in registry)"
    }
}

# Find orphan tech folders (exist but not registered)
$KnownKeys = $Registry.technologies.key
$TechDirs = @("rules", "prompts", "config", "templates")
foreach ($DirName in $TechDirs) {
    $DirPath = Join-Path $WorkspaceRoot $DirName
    if (-not (Test-Path $DirPath)) { continue }
    Get-ChildItem $DirPath -Directory | ForEach-Object {
        $FolderName = $_.Name
        $IsKnown = $KnownKeys -contains $FolderName
        $IsNonTech = $NonTechFolders -contains $FolderName
        if (-not $IsKnown -and -not $IsNonTech) {
            $Issues += "ORPHAN: $DirName/$FolderName/ (not registered in technologies.json)"
        }
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
