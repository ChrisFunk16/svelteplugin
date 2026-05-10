#Requires -Version 5.0
<#
.SYNOPSIS
    Removes Svelte language support from Notepad++
#>

$ErrorActionPreference = 'Stop'

Write-Host "Svelte Notepad++ Uninstaller" -ForegroundColor Cyan
Write-Host "============================" -ForegroundColor Cyan

$NppProc = Get-Process -Name 'notepad++' -ErrorAction SilentlyContinue
if ($NppProc) {
    Write-Host "Closing Notepad++..." -ForegroundColor Yellow
    $NppProc | Stop-Process
    Start-Sleep -Seconds 1
}

$Targets = @(
    "$env:APPDATA\Notepad++\userDefineLangs\Svelte.udl.xml",
    "$env:ProgramFiles\Notepad++\autoCompletion\Svelte.xml",
    "${env:ProgramFiles(x86)}\Notepad++\autoCompletion\Svelte.xml",
    "$env:APPDATA\Notepad++\plugins\APIs\Svelte.xml"
)

$Removed = 0
foreach ($t in $Targets) {
    if (Test-Path $t) {
        try {
            Remove-Item -Path $t -Force
            Write-Host "[OK] Removed: $t" -ForegroundColor Green
            $Removed++
        } catch {
            Write-Warning "Could not remove $t : $($_.Exception.Message)"
        }
    }
}

if ($Removed -eq 0) {
    Write-Host "Nothing to remove." -ForegroundColor Gray
} else {
    Write-Host "Done. $Removed file(s) removed." -ForegroundColor Green
}
