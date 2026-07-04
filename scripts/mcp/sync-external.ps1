#!/usr/bin/env pwsh
<#
.SYNOPSIS
    Links MCP servers from DEPRATI_BASE_PROJECT_PATH into local mcp/servers/.
    Usa symlinks si es posible, fallback a copia si no hay permisos.
.EXAMPLE
    .\scripts\mcp\sync-external.ps1
#>

$WorkspaceRoot = Split-Path -Parent (Split-Path -Parent $PSScriptRoot)
$LocalDir = Join-Path (Join-Path $WorkspaceRoot "mcp") "servers"
$Base = $env:DEPRATI_BASE_PROJECT_PATH

if (-not $Base) {
    Write-Warning "DEPRATI_BASE_PROJECT_PATH no está seteada. Nada que sincronizar."
    exit 0
}

$ExternalDir = Join-Path (Join-Path (Join-Path $Base ".opencode") "mcp") "servers"
if (-not (Test-Path $ExternalDir)) {
    Write-Warning "No se encontró MCP servers en $ExternalDir"
    exit 0
}

# Asegurar que localDir existe
if (-not (Test-Path $LocalDir)) {
    New-Item -ItemType Directory -Force -Path $LocalDir | Out-Null
}

# Limpiar enlaces stales anteriores
Get-ChildItem $LocalDir -Filter "ext.*.json" -ErrorAction SilentlyContinue | ForEach-Object {
    if ($_.LinkType) { Remove-Item $_.FullName -Force }
}

# Intentar symlink, fallback a copia
$UseSymlink = $true
try {
    $null = New-Item -ItemType SymbolicLink -Path (Join-Path $LocalDir "ext._test") -Target (Join-Path $ExternalDir ".") -Force -ErrorAction Stop
    Remove-Item (Join-Path $LocalDir "ext._test") -Force -ErrorAction SilentlyContinue
} catch {
    $UseSymlink = $false
    Write-Warning "Symlinks no disponibles (ejecutar como Admin o activar modo desarrollador). Usando copias."
}

$count = 0
Get-ChildItem $ExternalDir -Filter "*.json" | ForEach-Object {
    $linkName = "ext.$($_.Name)"
    $linkPath = Join-Path $LocalDir $linkName
    if ($UseSymlink) {
        New-Item -ItemType SymbolicLink -Path $linkPath -Target $_.FullName -Force | Out-Null
    } else {
        Copy-Item $_.FullName $linkPath -Force
    }
    $count++
}

Write-Host "[sync] $count MCP servers linked from external." -ForegroundColor Green
