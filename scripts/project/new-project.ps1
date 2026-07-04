#!/usr/bin/env pwsh
<#
.SYNOPSIS
    Creates a new project scaffolded from a template.
.EXAMPLE
    .\new-project.ps1 -Name "my-app" -Type "accelerator-sap-vue"
.PARAMETER Name
    Project name (kebab-case).
.PARAMETER Type
    Template type from technologies.json (e.g., "accelerator-sap-vue").
.PARAMETER Path
    Optional: output path (default: ../projects/<Name>).
#>

param(
    [Parameter(Mandatory = $true)]
    [string]$Name,
    [Parameter(Mandatory = $true)]
    [string]$Type,
    [string]$Path
)

$WorkspaceRoot = Split-Path -Parent (Split-Path -Parent $PSScriptRoot)
$RegistryPath = Join-Path (Join-Path (Join-Path $WorkspaceRoot "docs") "references") "technologies.json"

# Load registry and validate Type
if (-not (Test-Path $RegistryPath)) {
    Write-Error "Registry not found: $RegistryPath"
    exit 1
}

$Registry = Get-Content $RegistryPath -Raw | ConvertFrom-Json
$Tech = $Registry.technologies | Where-Object { $_.key -eq $Type }

if (-not $Tech) {
    $Available = ($Registry.technologies.key) -join ", "
    Write-Error "Unknown technology '$Type'. Available: $Available"
    exit 1
}

if (-not $Tech.has.template) {
    Write-Error "Technology '$Type' has no template yet. Set has.template = true in technologies.json first."
    exit 1
}

if (-not $Path) {
    $Path = Join-Path $WorkspaceRoot "projects" $Name
}

$TemplatePath = Join-Path (Join-Path $WorkspaceRoot "templates") $Type

if (-not (Test-Path $TemplatePath)) {
    Write-Error "Template not found: $TemplatePath"
    exit 1
}

if (Test-Path $Path) {
    Write-Error "Project already exists: $Path"
    exit 1
}

Write-Host "[new-project] Creating $Name ($Type) at $Path" -ForegroundColor Cyan

# Create project directory
New-Item -ItemType Directory -Force -Path $Path | Out-Null

# Copy template files
Copy-Item -Path "$TemplatePath\*" -Destination $Path -Recurse -Force

# Create project AGENTS.md
$AgentsContent = @"
# Project: $Name

## Description
TODO: Add description

## Technology
- **Stack**: $Type

## Architecture
TODO: Describe architecture

## Links
- **Tracker**: TODO
- **CI**: TODO
"@

$AgentsPath = Join-Path $Path "AGENTS.md"
Set-Content -Path $AgentsPath -Value $AgentsContent

# Create .gitkeep files for empty subdirs
$SubDirs = @("docs", "scripts", "rules", "specs")
foreach ($Dir in $SubDirs) {
    $DirPath = Join-Path $Path $Dir
    New-Item -ItemType Directory -Force -Path $DirPath | Out-Null
    $Gitkeep = Join-Path $DirPath ".gitkeep"
    Set-Content -Path $Gitkeep -Value "" -NoNewline
}

# Update PROJECTS_INDEX.md
$IndexPath = Join-Path (Join-Path $WorkspaceRoot "projects") "PROJECTS_INDEX.md"
$NewEntry = "| \`$Name\` | $Type | Active | TODO |"
Add-Content -Path $IndexPath -Value "`n$NewEntry"

Write-Host "[new-project] Project created: $Path" -ForegroundColor Green
Write-Host "[new-project] Next steps:" -ForegroundColor Yellow
Write-Host "  1. Edit $Path\AGENTS.md with project context"
