#Requires -Version 5.0
<#
.SYNOPSIS
    Installs Svelte language support for Notepad++

.DESCRIPTION
    Copies the UDL XML file and the autocomplete file to the correct
    Notepad++ directories. Closes Notepad++ first if running.

.PARAMETER Theme
    'Dark' (default, VSCode-like) or 'Light'

.EXAMPLE
    .\install.ps1
    .\install.ps1 -Theme Light
#>

[CmdletBinding()]
param(
    [ValidateSet('Dark', 'Light')]
    [string]$Theme = 'Dark'
)

$ErrorActionPreference = 'Stop'

Write-Host "Svelte Notepad++ Installer" -ForegroundColor Cyan
Write-Host "==========================" -ForegroundColor Cyan

# Resolve paths
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$RepoRoot = Split-Path -Parent $ScriptDir
$UdlFile = if ($Theme -eq 'Light') {
    Join-Path $RepoRoot 'udl\Svelte-Light.xml'
} else {
    Join-Path $RepoRoot 'udl\Svelte.xml'
}
$AutoCompleteFile = Join-Path $RepoRoot 'autocomplete\Svelte.xml'

if (-not (Test-Path $UdlFile)) {
    Write-Error "UDL file not found: $UdlFile"
}

# Detect Notepad++ install location
$NppRoots = @(
    "$env:ProgramFiles\Notepad++",
    "${env:ProgramFiles(x86)}\Notepad++"
) | Where-Object { Test-Path $_ }

$UserConfig = "$env:APPDATA\Notepad++"
if (-not (Test-Path $UserConfig)) {
    Write-Host "Notepad++ user config not found - creating: $UserConfig" -ForegroundColor Yellow
    New-Item -ItemType Directory -Path $UserConfig -Force | Out-Null
}

if (-not $NppRoots) {
    Write-Warning "Notepad++ install dir not found in Program Files. UDL will still install (uses %APPDATA%)."
    $InstallRoot = $null
} else {
    $InstallRoot = $NppRoots | Select-Object -First 1
}

Write-Host "User config: $UserConfig" -ForegroundColor Gray
if ($InstallRoot) {
    Write-Host "Install root: $InstallRoot" -ForegroundColor Gray
}

# Close Notepad++ if running (it locks userDefineLang.xml)
$NppProc = Get-Process -Name 'notepad++' -ErrorAction SilentlyContinue
if ($NppProc) {
    Write-Host "Notepad++ is running - closing it..." -ForegroundColor Yellow
    $NppProc | Stop-Process
    Start-Sleep -Seconds 1
}

# Install UDL
$UdlTargetDir = Join-Path $UserConfig 'userDefineLangs'
if (-not (Test-Path $UdlTargetDir)) {
    New-Item -ItemType Directory -Path $UdlTargetDir -Force | Out-Null
}
$UdlTarget = Join-Path $UdlTargetDir 'Svelte.udl.xml'
Copy-Item -Path $UdlFile -Destination $UdlTarget -Force
Write-Host "[OK] UDL installed: $UdlTarget" -ForegroundColor Green

# Install Autocomplete
if ($InstallRoot) {
    $AcTargetDir = Join-Path $InstallRoot 'autoCompletion'
} else {
    $AcTargetDir = Join-Path $UserConfig 'plugins\APIs'
}

if (-not (Test-Path $AcTargetDir)) {
    try {
        New-Item -ItemType Directory -Path $AcTargetDir -Force | Out-Null
    } catch {
        Write-Warning "Cannot create autocomplete dir: $AcTargetDir - skipping"
        $AcTargetDir = $null
    }
}

if ($AcTargetDir -and (Test-Path $AutoCompleteFile)) {
    $AcTarget = Join-Path $AcTargetDir 'Svelte.xml'
    try {
        Copy-Item -Path $AutoCompleteFile -Destination $AcTarget -Force
        Write-Host "[OK] Autocomplete installed: $AcTarget" -ForegroundColor Green
    } catch {
        Write-Warning "Could not install autocomplete (try running as admin): $($_.Exception.Message)"
    }
}

Write-Host ""
Write-Host "Done! Start Notepad++ and open a .svelte file." -ForegroundColor Green
Write-Host "Make sure auto-completion is enabled:" -ForegroundColor Gray
Write-Host "  Settings -> Preferences -> Auto-Completion -> Enable auto-completion" -ForegroundColor Gray
