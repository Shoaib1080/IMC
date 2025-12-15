<#
  cleanup-choco-locks.ps1 (wrapper)
  This file is a concise wrapper that delegates to `cleanup-choco-locks.clean.ps1`.
  It preserves the entry point, supports `-Force`, `-ToolBasename`, and `-WhatIf`.
#>

[CmdletBinding()]
param(
    [switch]$WhatIf,
    [switch]$Force,
    [string]$ToolBasename = 'terraform.exe'
)

$scriptDir = Split-Path -Parent $PSCommandPath
$cleanScript = Join-Path $scriptDir 'cleanup-choco-locks.clean.ps1'

if (Test-Path -Path $cleanScript -PathType Leaf) {
    Write-Host "Running fixed cleanup script at: $cleanScript"
    $invokeParams = @{
        Force = $Force
        ToolBasename = $ToolBasename
    }
    if ($WhatIf) { & $cleanScript @invokeParams -WhatIf } else { & $cleanScript @invokeParams }
} else {
    Write-Error "Cannot find cleanup-choco-locks.clean.ps1. Please restore the fixed script or run the cleanup logic manually."
}
<#
  cleanup-choco-locks.ps1 (wrapper)
  This file is a concise wrapper that delegates to `cleanup-choco-locks.clean.ps1`.
  It preserves the entry point, supports `-Force`, `-ToolBasename`, and `-WhatIf`.
#>

[CmdletBinding()]
param(
    [switch]$WhatIf,
    [switch]$Force,
    [string]$ToolBasename = 'terraform.exe'
)

$scriptDir = Split-Path -Parent $PSCommandPath
$cleanScript = Join-Path $scriptDir 'cleanup-choco-locks.clean.ps1'

if (Test-Path -Path $cleanScript -PathType Leaf) {
    Write-Host "Running fixed cleanup script at: $cleanScript"
    $invokeParams = @{
        Force = $Force
        ToolBasename = $ToolBasename
    }
    if ($WhatIf) {
        & $cleanScript @invokeParams -WhatIf
    } else {
        & $cleanScript @invokeParams
    }
} else {
    Write-Error "Cannot find cleanup-choco-locks.clean.ps1. Please restore the fixed script or run the cleanup logic manually."
}
<#
  cleanup-choco-locks.ps1
  Purpose: Interactive script to cleanup Chocolatey lock files that are leftover after a failed install.
  NOTE: Requires Administrator rights. This script will prompt before deleting.
  Usage: .\cleanup-choco-locks.ps1 [-Force] [-ToolBasename 'terraform.exe'] [-WhatIf]
    -Force: Bypass interactive confirmations and remove matches immediately
    -ToolBasename: The basename of a tool executable to detect under package folders
 

# Ensure script is running with Administrator rights
$principal = New-Object System.Security.Principal.WindowsPrincipal([System.Security.Principal.WindowsIdentity]::GetCurrent())
if (-not $principal.IsInRole([System.Security.Principal.WindowsBuiltinRole]::Administrator)) {
    Write-Host "This script requires Administrator privileges. Please re-run as Administrator." -ForegroundColor Red
    exit 1
}

if (-not (Test-Path -Path $defaultLibPath -PathType Container)) {
    Write-Host "Chocolatey lib path not found: $defaultLibPath" -ForegroundColor Yellow
    return
}

try {
    $candidates = Get-ChildItem -Path $defaultLibPath -Directory -Force -ErrorAction SilentlyContinue
} catch {
    Write-Warning "Unable to enumerate the Chocolatey lib folder: $($_.Exception.Message)"
    return
}

# Look for directories with long hashes (40 hex characters), directories that have a 'tools' subdir, or ones matching the tool basename
foreach ($c in $candidates) {
    $matchHash = ($c.Name -match '^[a-f0-9]{40}$')
    $hasToolsDir = Test-Path (Join-Path $c.FullName 'tools')
    $hasToolBasename = Test-Path (Join-Path $c.FullName $ToolBasename)
    if ($matchHash -or $hasToolsDir -or $hasToolBasename) {
        Confirm-And-Remove $c.FullName -Force:$Force
    }
}

Write-Host "Cleanup complete. If you removed items, you can try reinstall again." -ForegroundColor Green
<#
    NOTE: Everything below was removed because this wrapper delegates to the clean script
    `cleanup-choco-locks.clean.ps1`. The content that used to exist here was a mixture of
    duplicated and concatenated copies of the functionality. Keep the wrapper simple and
    delegate to the fixed implementation instead.
#>
<#
  cleanup-choco-locks.ps1
  Purpose: Interactive script to cleanup Chocolatey lock files that are leftover after a failed install.
  NOTE: Requires Administrator rights. This script will prompt before deleting.
  Usage: .\cleanup-choco-locks.ps1 [-Force] [-ToolBasename 'terraform.exe'] [-WhatIf]
    -Force: Bypass interactive confirmations and remove matches immediately
    -ToolBasename: The basename of a tool executable to detect under package folders
#>

 
[CmdletBinding()]
param(
    [switch]$WhatIf,
    [switch]$Force,
    [string]$ToolBasename = 'terraform.exe'
)

$ErrorActionPreference = 'Stop'

# Candidate locations
$defaultLibPath = 'C:\ProgramData\chocolatey\lib'
$pendingRebootFile = 'C:\Windows\WinSxS\Pending.xml'

function Confirm-And-Remove ($path, [switch]$WhatIf, [switch]$Force) {
    if (-not (Test-Path -Path $path)) { return }
    Write-Host "Found: $($path)" -ForegroundColor Yellow
    if ($Force) {
        $doRemove = $true
    } else {
        $meta = Get-Item -LiteralPath $path -ErrorAction SilentlyContinue
        $confirm = Read-Host "Remove package folder '$($meta.Name)' at '$path'? (Y/N)"
        $doRemove = $confirm -match '^[Yy]'
    }
    if ($doRemove) {
        try {
            if ($WhatIf) {
                Write-Host "WhatIf: Would remove $($path)" -ForegroundColor Yellow
            } else {
                Remove-Item -LiteralPath $path -Force -Recurse -ErrorAction Stop
                Write-Host "Removed $($path)" -ForegroundColor Green
            }
        } catch {
            Write-Warning "Failed to remove $($path): $($_.Exception.Message)"
        }
    } else {
        Write-Host "Skipping $($path)" -ForegroundColor Cyan
    }
}

# Ensure script is running with Administrator rights
$principal = New-Object System.Security.Principal.WindowsPrincipal([System.Security.Principal.WindowsIdentity]::GetCurrent())
if (-not $principal.IsInRole([System.Security.Principal.WindowsBuiltinRole]::Administrator)) {
    Write-Host "This script requires Administrator privileges. Please re-run as Administrator." -ForegroundColor Red
    exit 1
}

if (-not (Test-Path -Path $defaultLibPath -PathType Container)) {
    Write-Host "Chocolatey lib path not found: $defaultLibPath" -ForegroundColor Yellow
    return
}

try {
    $candidates = Get-ChildItem -Path $defaultLibPath -Directory -Force -ErrorAction SilentlyContinue
} catch {
    Write-Warning "Unable to enumerate the Chocolatey lib folder: $($_.Exception.Message)"
    return
}

# Look for directories with long hashes (40 hex characters), directories that have a 'tools' subdir, or ones matching the tool basename
foreach ($c in $candidates) {
    $matchHash = ($c.Name -match '^[a-f0-9]{40}$')
    $hasToolsDir = Test-Path (Join-Path $c.FullName 'tools')
    $hasToolBasename = Test-Path (Join-Path $c.FullName $ToolBasename)
    if ($matchHash -or $hasToolsDir -or $hasToolBasename) {
        Confirm-And-Remove $c.FullName -WhatIf:$WhatIf -Force:$Force
    }
}

Write-Host "Cleanup complete. If you removed items, you can try reinstall again." -ForegroundColor Green
<#
  cleanup-choco-locks.ps1
  Purpose: Interactive script to cleanup Chocolatey lock files that are leftover after a failed install.
  NOTE: Requires Administrator rights. This script will prompt before deleting.
  Usage: .\cleanup-choco-locks.ps1 [-WhatIf] [-Force]
    -WhatIf: Dry-run, display what would be removed instead of deleting
    -Force: Bypass interactive confirmations and remove matches immediately
#>

param(
    [switch]$WhatIf,
    [switch]$Force
)

$ErrorActionPreference = 'Stop'

# Candidate locations
$defaultLibPath = 'C:\ProgramData\chocolatey\lib'
$pendingRebootFile = 'C:\Windows\WinSxS\Pending.xml'

function Confirm-And-Remove($path, [switch]$WhatIf, [switch]$Force) {
    if (Test-Path $path) {
        Write-Host "Found: $($path)" -ForegroundColor Yellow
        if ($Force) {
            $doRemove = $true
        } else {
            $confirm = Read-Host "Do you want to remove $path? (Y/N)"
            $doRemove = $confirm -match '^[Yy]'
        }
        if ($doRemove) {
            try {
                if ($WhatIf) {
                    Write-Host "WhatIf: Would remove $($path)" -ForegroundColor Yellow
                } else {
                    Remove-Item -Path $path -Force -Recurse
                    Write-Host "Removed $($path)" -ForegroundColor Green
                }
            } catch {
                # Use the exception message to avoid parsing issues in string interpolation
                Write-Warning "Failed to remove $($path): $($_.Exception.Message)"
            }
        } else {
            Write-Host "Skipping $($path)" -ForegroundColor Cyan
        }
    }
}

# Ensure script is running with Administrator rights
$principal = New-Object System.Security.Principal.WindowsPrincipal([System.Security.Principal.WindowsIdentity]::GetCurrent())
if (-not $principal.IsInRole([System.Security.Principal.WindowsBuiltinRole]::Administrator)) {
    Write-Host "This script requires Administrator privileges. Please re-run as Administrator." -ForegroundColor Red
    exit 1
}

if (Test-Path $defaultLibPath) {
    # Only look at directories
    $candidates = Get-ChildItem -Path $defaultLibPath -Directory -Force -ErrorAction SilentlyContinue
    foreach ($c in $candidates) {
        # Look for directories with long hashes or partially installed packages
        if ( ($c.Name -match '^[a-f0-9]{40}$') -or (Test-Path (Join-Path $c.FullName 'tools')) -or ( (-not (Test-Path (Join-Path $c.FullName 'tools\terraform.exe'))) -and ($c.Name -match 'terraform') ) ) {
            Confirm-And-Remove $c.FullName -WhatIf:$WhatIf -Force:$Force
        }
    }
} else {
    Write-Host "Chocolatey lib path not found: $defaultLibPath" -ForegroundColor Yellow
}

Write-Host "Cleanup complete. If you removed items, you can try reinstall again." -ForegroundColor Green
<#
  cleanup-choco-locks.ps1
  Purpose: Interactive script to cleanup Chocolatey lock files that are leftover after a failed install.
  NOTE: Requires Administrator rights. This script will prompt before deleting.
  Usage: .\cleanup-choco-locks.ps1 [-WhatIf] [-Force]
    -WhatIf: Dry-run, display what would be removed instead of deleting
    -Force: Bypass interactive confirmations and remove matches immediately
#>

param(
    [switch]$WhatIf,
    [switch]$Force
)

$ErrorActionPreference = 'Stop'

# Candidate locations
$defaultLibPath = 'C:\ProgramData\chocolatey\lib'
$pendingRebootFile = 'C:\Windows\WinSxS\Pending.xml'

function Confirm-And-Remove($path, [switch]$WhatIf, [switch]$Force) {
    if (Test-Path $path) {
        Write-Host "Found: $($path)" -ForegroundColor Yellow
        if ($Force) {
            $doRemove = $true
        } else {
            $confirm = Read-Host "Do you want to remove $path? (Y/N)"
            $doRemove = $confirm -match '^[Yy]'
        }
        if ($doRemove) {
            try {
                if ($WhatIf) {
                    Write-Host "WhatIf: Would remove $($path)" -ForegroundColor Yellow
                } else {
                    Remove-Item -Path $path -Force -Recurse
                    Write-Host "Removed $($path)" -ForegroundColor Green
                }
            } catch {
                # Use the exception message to avoid parsing issues in string interpolation
                Write-Warning "Failed to remove $($path): $($_.Exception.Message)"
            }
        } else {
            Write-Host "Skipping $($path)" -ForegroundColor Cyan
        }
    }
}

# Ensure script is running with Administrator rights
$principal = New-Object System.Security.Principal.WindowsPrincipal([System.Security.Principal.WindowsIdentity]::GetCurrent())
if (-not $principal.IsInRole([System.Security.Principal.WindowsBuiltinRole]::Administrator)) {
    Write-Host "This script requires Administrator privileges. Please re-run as Administrator." -ForegroundColor Red
    exit 1
}

if (Test-Path $defaultLibPath) {
    # Only look at directories
    $candidates = Get-ChildItem -Path $defaultLibPath -Directory -Force -ErrorAction SilentlyContinue
    foreach ($c in $candidates) {
        # Look for directories with long hashes or partially installed packages
        if ( ($c.Name -match '^[a-f0-9]{40}$') -or (Test-Path (Join-Path $c.FullName 'tools')) -or ( (-not (Test-Path (Join-Path $c.FullName 'tools\terraform.exe'))) -and ($c.Name -match 'terraform') ) ) {
            Confirm-And-Remove $c.FullName -WhatIf:$WhatIf -Force:$Force
        }
    }
} else {
    Write-Host "Chocolatey lib path not found: $defaultLibPath" -ForegroundColor Yellow
}

Write-Host "Cleanup complete. If you removed items, you can try reinstall again." -ForegroundColor Green
<#
  cleanup-choco-locks.ps1
  Purpose: Interactive script to cleanup Chocolatey lock files that are leftover after a failed install.
  NOTE: Requires Administrator rights. This script will prompt before deleting.
  Usage: .\cleanup-choco-locks.ps1 [-WhatIf] [-Force]
    -WhatIf: Dry-run, display what would be removed instead of deleting
    -Force: Bypass interactive confirmations and remove matches immediately
#>

param(
    [switch]$WhatIf,
    [switch]$Force
)

$ErrorActionPreference = 'Stop'

# Candidate locations
$defaultLibPath = 'C:\ProgramData\chocolatey\lib'
$pendingRebootFile = 'C:\Windows\WinSxS\Pending.xml'

function Confirm-And-Remove($path, [switch]$WhatIf, [switch]$Force) {
    if (Test-Path $path) {
        Write-Host "Found: $($path)" -ForegroundColor Yellow
        if ($Force) {
            $doRemove = $true
        } else {
            $confirm = Read-Host "Do you want to remove $path? (Y/N)"
            $doRemove = $confirm -match '^[Yy]'
        }
        if ($doRemove) {
            try {
                if ($WhatIf) {
                    Write-Host "WhatIf: Would remove $($path)" -ForegroundColor Yellow
                } else {
                    Remove-Item -Path $path -Force -Recurse
                    Write-Host "Removed $($path)" -ForegroundColor Green
                }
            } catch {
                # Use the exception message to avoid parsing issues in string interpolation
                Write-Warning "Failed to remove $($path): $($_.Exception.Message)"
            }
        } else {
            Write-Host "Skipping $($path)" -ForegroundColor Cyan
        }
    }
}

# Ensure script is running with Administrator rights
$principal = New-Object System.Security.Principal.WindowsPrincipal([System.Security.Principal.WindowsIdentity]::GetCurrent())
if (-not $principal.IsInRole([System.Security.Principal.WindowsBuiltinRole]::Administrator)) {
    Write-Host "This script requires Administrator privileges. Please re-run as Administrator." -ForegroundColor Red
    exit 1
}

if (Test-Path $defaultLibPath) {
    # Only look at directories
    $candidates = Get-ChildItem -Path $defaultLibPath -Directory -Force -ErrorAction SilentlyContinue
    foreach ($c in $candidates) {
        # Look for directories with long hashes or partially installed packages
        if ( ($c.Name -match '^[a-f0-9]{40}$') -or (Test-Path (Join-Path $c.FullName 'tools')) -or ( (-not (Test-Path (Join-Path $c.FullName 'tools\terraform.exe'))) -and ($c.Name -match 'terraform') ) ) {
            Confirm-And-Remove $c.FullName -WhatIf:$WhatIf -Force:$Force
        }
    }
} else {
    Write-Host "Chocolatey lib path not found: $defaultLibPath" -ForegroundColor Yellow
}

Write-Host "Cleanup complete. If you removed items, you can try reinstall again." -ForegroundColor Green
<#
  cleanup-choco-locks.ps1
  Purpose: Interactive script to cleanup Chocolatey lock files that are leftover after a failed install.
    NOTE: Requires Administrator rights. This script will prompt before deleting.
    Usage: .\cleanup-choco-locks.ps1 [-WhatIf] [-Force]
        -WhatIf: Dry-run, display what would be removed instead of deleting
        -Force: Bypass interactive confirmations and remove matches immediately
#>

$ErrorActionPreference = 'Stop'

# Candidate locations
$defaultLibPath = 'C:\ProgramData\chocolatey\lib'
$pendingRebootFile = 'C:\Windows\WinSxS\Pending.xml'

function Confirm-And-Remove($path, [switch]$WhatIf, [switch]$Force) {
    if (Test-Path $path) {
        Write-Host "Found: $($path)" -ForegroundColor Yellow
        $confirm = Read-Host "Do you want to remove $path? (Y/N)"
        if ($confirm -match '^[Yy]') {
            try {
                if ($WhatIf) {
                    Write-Host "WhatIf: Would remove $($path)" -ForegroundColor Yellow
                        if ($Force) {
                            $doRemove = $true
                        } else {
                            $confirm = Read-Host "Do you want to remove $path? (Y/N)"
                            $doRemove = $confirm -match '^[Yy]'
                        }
                        if ($doRemove) {
                    Write-Host "Removed $($path)" -ForegroundColor Green
                }
            } catch {
                # Use $($_.Exception.Message) to avoid parsing issues with ":" inside the string
                Write-Warning "Failed to remove $($path): $($_.Exception.Message)"
            }
        } else {
            Write-Host "Skipping $($path)" -ForegroundColor Cyan
        }
    }
}

# Ensure script is running with Administrator rights
$principal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
if (-not $principal.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)) {
    Write-Host "This script requires Administrator privileges. Please re-run as Administrator." -ForegroundColor Red
    exit 1
}

                    [switch]$Force
param(
    [switch]$WhatIf
)

if (Test-Path $defaultLibPath) {
    # Only look at directories
    $candidates = Get-ChildItem -Path $defaultLibPath -Directory -Force -ErrorAction SilentlyContinue
    foreach ($c in $candidates) {
                            Confirm-And-Remove $c.FullName -WhatIf:$WhatIf -Force:$Force
        if ( ($c.Name -match '^[a-f0-9]{40}$') -or (Test-Path (Join-Path $c.FullName 'tools')) -or ( (-not (Test-Path (Join-Path $c.FullName 'tools\terraform.exe'))) -and ($c.Name -match 'terraform') ) ) {
            Confirm-And-Remove $c.FullName -WhatIf:$WhatIf
        }
    }
} else {
    Write-Host "Chocolatey lib path not found: $defaultLibPath" -ForegroundColor Yellow
}

Write-Host "Cleanup complete. If you removed items, you can try reinstall again." -ForegroundColor Green

