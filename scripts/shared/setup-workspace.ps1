#!/usr/bin/env pwsh
<#
.SYNOPSIS
    Initial setup for the AI Developer Workspace.
#>

$WorkspaceRoot = Split-Path -Parent (Split-Path -Parent $PSScriptRoot)
Write-Host "Setting up AI Developer Workspace..." -ForegroundColor Cyan

# Check prerequisites
$Prereqs = @(
    @{Name="Git"; Command="git --version"}
    @{Name="Docker"; Command="docker --version"}
    @{Name="PowerShell 7+"; Command="pwsh --version"}
)

foreach ($Prereq in $Prereqs) {
    try {
        $null = Invoke-Expression $Prereq.Command 2>$null
        Write-Host "  [OK] $($Prereq.Name)" -ForegroundColor Green
    } catch {
        Write-Host "  [WARN] $($Prereq.Name) not found" -ForegroundColor Yellow
    }
}

# Create required directories
$Dirs = @(
    ".opencode/agents",
    ".opencode/skills",
    ".opencode/permissions",
    "projects",
    "knowledge-base/learnings",
    "knowledge-base/decisions"
)

foreach ($Dir in $Dirs) {
    $Path = Join-Path $WorkspaceRoot $Dir
    if (-not (Test-Path $Path)) {
        New-Item -ItemType Directory -Force -Path $Path | Out-Null
        Write-Host "  [CREATE] $Path" -ForegroundColor Gray
    }
}

# Git hooks
$HooksPath = Join-Path $WorkspaceRoot ".git" "hooks"
$SharedHooks = Join-Path $WorkspaceRoot "workflows" "hooks"

if (Test-Path $SharedHooks) {
    Get-ChildItem $SharedHooks -Filter "*.ps1" | ForEach-Object {
        $HookName = $_.BaseName -replace '\.ps1$', ''
        $HookPath = Join-Path $HooksPath $HookName
        Copy-Item $_.FullName $HookPath -Force
        Write-Host "  [HOOK] $HookName installed" -ForegroundColor Gray
    }
}

Write-Host "Setup complete!" -ForegroundColor Green
Write-Host "Workspace: $WorkspaceRoot" -ForegroundColor Cyan
