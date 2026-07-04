#!/usr/bin/env pwsh
<#
.SYNOPSIS
    Creates a new project scaffolded from a template.
.EXAMPLE
    .\new-project.ps1 -Name "my-api" -Type "spring-boot"
.PARAMETER Name
    Project name (kebab-case).
.PARAMETER Type
    Template type: angular, spring-boot, node-js, ruby-on-rails, library.
.PARAMETER Path
    Optional: output path (default: ../projects/<Name>).
#>
param(
    [Parameter(Mandatory = $true)]
    [string]$Name,
    [Parameter(Mandatory = $true)]
    [ValidateSet("angular", "spring-boot", "node-js", "ruby-on-rails", "library")]
    [string]$Type,
    [string]$Path
)

$WorkspaceRoot = Split-Path -Parent (Split-Path -Parent $PSScriptRoot)

if (-not $Path) {
    $Path = Join-Path $WorkspaceRoot "projects" $Name
}

$TemplatePath = Join-Path $WorkspaceRoot "templates" $Type

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
- **Language**: TODO
- **Build**: TODO

## Architecture
TODO: Describe architecture

## Directories

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
$IndexPath = Join-Path $WorkspaceRoot "projects" "PROJECTS_INDEX.md"
$NewEntry = "| \`$Name\` | $Type | Active | TODO |"
Add-Content -Path $IndexPath -Value "`n$NewEntry"

Write-Host "[new-project] Project created: $Path" -ForegroundColor Green
Write-Host "[new-project] Next steps:" -ForegroundColor Yellow
Write-Host "  1. Edit $Path\AGENTS.md with project context"
Write-Host "  2. Run initial build: cd $Path && make setup"
