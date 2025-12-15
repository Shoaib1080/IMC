<#
  cleanup-choco-locks.clean.ps1 - FIXED COPY
  Purpose: Robust and safe cleanup helper for Chocolatey leftovers.
  Usage examples:
    - Dry-run: .\cleanup-choco-locks.clean.ps1 -WhatIf
    - Force remove: .\cleanup-choco-locks.clean.ps1 -Force
    - Default tool basename: terraform.exe (can pass -ToolBasename 'foo.exe')
#>

[CmdletBinding(SupportsShouldProcess=$true)]
param(
    [switch]$Force,
    [string]$ToolBasename = 'terraform.exe'
)

$ErrorActionPreference = 'Stop'

# Candidate locations
$defaultLibPath = 'C:\ProgramData\chocolatey\lib'

[CmdletBinding(SupportsShouldProcess=$true)]
function Confirm-And-Remove {
    param(
        [Parameter(Mandatory=$true, ValueFromPipeline=$true)]
        [string]$path,
        [switch]$Force
    )
    if (-not (Test-Path -Path $path -PathType Container)) { return }
    Write-Host "Found: $($path)" -ForegroundColor Yellow
    if ($Force) { $doRemove = $true } else { $meta = Get-Item -LiteralPath $path -ErrorAction SilentlyContinue; $confirm = Read-Host "Remove package folder '$($meta.Name)' at '$path'? (Y/N)"; $doRemove = $confirm -match '^[Yy]' }
    if ($doRemove) {
        try {
            if ($PSCmdlet.ShouldProcess($path, 'Remove')) {
                Remove-Item -LiteralPath $path -Force -Recurse -ErrorAction Stop
                Write-Host "Removed $($path)" -ForegroundColor Green
            } else {
                Write-Host "WhatIf: Would remove $($path)" -ForegroundColor Yellow
            }
        } catch {
            Write-Warning "Failed to remove $($path): $($_.Exception.Message)"
        }
    } else { Write-Host "Skipping $($path)" -ForegroundColor Cyan }
}

# Ensure script is running with Administrator rights
$principal = New-Object System.Security.Principal.WindowsPrincipal([System.Security.Principal.WindowsIdentity]::GetCurrent())
if (-not $principal.IsInRole([System.Security.Principal.WindowsBuiltinRole]::Administrator)) { Write-Host "This script requires Administrator privileges. Please re-run as Administrator." -ForegroundColor Red; exit 1 }

if (-not (Test-Path -Path $defaultLibPath -PathType Container)) { Write-Host "Chocolatey lib path not found: $defaultLibPath" -ForegroundColor Yellow; return }

try { $candidates = Get-ChildItem -Path $defaultLibPath -Directory -Force -ErrorAction SilentlyContinue } catch { Write-Warning "Unable to enumerate the Chocolatey lib folder: $($_.Exception.Message)"; return }

foreach ($c in $candidates) {
    $matchHash = ($c.Name -match '^[a-f0-9]{40}$')
    $hasToolsDir = Test-Path (Join-Path $c.FullName 'tools')
    $hasToolBasename = Test-Path (Join-Path $c.FullName $ToolBasename)
    if ($matchHash -or $hasToolsDir -or $hasToolBasename) { Confirm-And-Remove $c.FullName -Force:$Force }
}

Write-Host "Cleanup complete. If you removed items, you can try reinstall again." -ForegroundColor Green
