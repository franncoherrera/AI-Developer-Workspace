#!/usr/bin/env pwsh
<#
.SYNOPSIS
    Registers a new technology in the workspace and creates its folder structure.
.EXAMPLE
    .\register-technology.ps1 -Key "spring-boot" -Name "Spring Boot 3.x"
.PARAMETER Key
    Technology key in kebab-case (e.g., "spring-boot").
.PARAMETER Name
    Human-readable name (e.g., "Spring Boot 3.x").
#>

param(
    [Parameter(Mandatory = $true)]
    [string]$Key,
    [Parameter(Mandatory = $true)]
    [string]$Name
)

$WorkspaceRoot = Split-Path -Parent (Split-Path -Parent $PSScriptRoot)
$RegistryPath = Join-Path (Join-Path (Join-Path $WorkspaceRoot "docs") "references") "technologies.json"

# Load registry
if (-not (Test-Path $RegistryPath)) {
    Write-Error "Registry not found: $RegistryPath"
    exit 1
}

$Registry = Get-Content $RegistryPath -Raw | ConvertFrom-Json

# Check key doesn't exist
if ($Registry.technologies.key -contains $Key) {
    Write-Error "Technology '$Key' is already registered."
    exit 1
}

# Create folders
$Folders = @{
    "rules/$Key"       = "rules/_template/AGENTS.md"
    "prompts/$Key"     = $null
    "config/$Key"      = $null
    "templates/$Key"   = $null
}

Write-Host "[register] Creating folders for '$Key'..." -ForegroundColor Cyan

foreach ($Folder in $Folders.Keys) {
    $Path = Join-Path $WorkspaceRoot $Folder
    New-Item -ItemType Directory -Force -Path $Path | Out-Null

    $Template = $Folders[$Folder]
    if ($Template) {
        $TemplatePath = Join-Path $WorkspaceRoot $Template
        if (Test-Path $TemplatePath) {
            $Dest = Join-Path $Path "AGENTS.md"
            Copy-Item $TemplatePath $Dest -Force
            Write-Host "  [OK] $Folder/AGENTS.md (from template)" -ForegroundColor Green
        }
    } else {
        Write-Host "  [OK] $Folder/" -ForegroundColor Gray
    }
}

# Register in JSON
$Entry = @{
    key    = $Key
    name   = $Name
    status = "planned"
    has    = @{
        rules    = $true
        prompts  = $false
        config   = $false
        template = $false
    }
}

$Registry.technologies += $Entry
$Registry | ConvertTo-Json -Depth 4 | Set-Content $RegistryPath -Encoding UTF8

Write-Host "[register] Technology '$Key' registered." -ForegroundColor Green
Write-Host "[register] Next steps:" -ForegroundColor Yellow
Write-Host "  1. Write rules/$Key/AGENTS.md"
Write-Host "  2. Add prompts to prompts/$Key/"
Write-Host "  3. Add configs to config/$Key/"
Write-Host "  4. Create template in templates/$Key/"
Write-Host "  5. Update technologies.json: set has.* = true, status = 'active'"
Write-Host "  6. Run .\scripts\utils\validate-rules.ps1"
