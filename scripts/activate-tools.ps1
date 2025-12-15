<#
  activate-tools.ps1
  Purpose: Temporarily add repo tools (for example, terraform) to the PATH for the current PowerShell session.
  Usage: .\activate-tools.ps1 [-ToolBasename 'terraform.exe']
#>

[CmdletBinding()]
param(
    [string]$ToolBasename = 'terraform.exe'
)

$ErrorActionPreference = 'Stop'

try {
    $repoRoot = Split-Path -Parent $PSScriptRoot
    $toolsDir = Join-Path $repoRoot 'tools'
} catch {
    Write-Warning "Unable to compute repo root: $($_.Exception.Message)"
    return
}

if (-not (Test-Path -Path $toolsDir -PathType Container)) {
    Write-Host "No tools directory found at $toolsDir; nothing to activate." -ForegroundColor Yellow
    return
}

try {
    $candidateDirs = Get-ChildItem -Path $toolsDir -Directory -ErrorAction SilentlyContinue
} catch {
    Write-Warning "Failed to enumerate tools directory: $($_.Exception.Message)"
    return
}

$foundDirs = @()
foreach ($d in $candidateDirs) {
    $candidatePath = Join-Path $d.FullName $ToolBasename
    if (Test-Path -Path $candidatePath) { $foundDirs += $d.FullName }
}

if ($foundDirs.Count -gt 0) {
    $addedDirs = @()
    foreach ($dirPath in $foundDirs) {
        if ($env:PATH -notlike "*$dirPath*") {
            $env:PATH = "$dirPath;$env:PATH"
            $addedDirs += $dirPath
        }
    }
    Write-Host "Added tools directories to PATH for this session:" -ForegroundColor Green
    foreach ($p in $addedDirs) { Write-Host " - $p" }
    Write-Host "Run '$ToolBasename -version' to confirm." -ForegroundColor Green
} else {
    Write-Host "No $ToolBasename found under $toolsDir. Use scripts/install-terraform.ps1 to install it locally." -ForegroundColor Yellow
}
