<#
    install-terraform.ps1

    Helper script to download Terraform binary for Windows and extract to ./tools/terraform
    Usage: .\install-terraform.ps1 -Version 1.6.7
    Default version is 1.6.7. You can also use 'latest' (attempts to use latest stable version parsing).
#>
param(
    [string]$Version = "latest"
)

$ErrorActionPreference = 'Stop'

$repoRoot = Split-Path -Parent $PSScriptRoot
$toolsDir = Join-Path $repoRoot 'tools'
$terraformDir = Join-Path $toolsDir 'terraform'

if (-Not (Test-Path $toolsDir)) {
    New-Item -ItemType Directory -Path $toolsDir -Force | Out-Null
}
if (-Not (Test-Path $terraformDir)) {
    New-Item -ItemType Directory -Path $terraformDir -Force | Out-Null
}

if ($Version -eq 'latest') {
    # Fetch the latest stable version from releases.hashicorp.com
    try {
        $indexUrl = 'https://releases.hashicorp.com/terraform/index.json'
        Write-Host "Fetching Terraform releases index..."
        $index = Invoke-RestMethod -Uri $indexUrl -UseBasicParsing
        # `current` contains the current version, fallback to first version in `versions`
        $Version = $index.current
        Write-Host "Latest terraform version: $Version"
    } catch {
        Write-Host "Failed to fetch latest version, defaulting to 1.6.7"
        $Version = '1.6.7'
    }
}

# Normalize version
$NormalizedVersion = $Version.TrimStart('v')

$zipFile = Join-Path $toolsDir "terraform_${NormalizedVersion}_windows_amd64.zip"
$url = "https://releases.hashicorp.com/terraform/$NormalizedVersion/terraform_${NormalizedVersion}_windows_amd64.zip"

if (Test-Path $zipFile) {
    Write-Host "Found existing zip: $zipFile"
} else {
    Write-Host "Downloading Terraform $NormalizedVersion from $url..."
    Invoke-WebRequest -Uri $url -OutFile $zipFile
}

Write-Host "Extracting $zipFile to $terraformDir ..."
Expand-Archive -Path $zipFile -DestinationPath $terraformDir -Force

$terraformExe = Join-Path $terraformDir 'terraform.exe'
if (-Not (Test-Path $terraformExe)) {
    Write-Error "terraform.exe not found after extraction"
    exit 1
}

# Add the binary directory to current session PATH (temporary)
$env:PATH = "$($terraformDir);$($env:PATH)"
Write-Host "Added $terraformDir to PATH for this session. Run `terraform -version` to verify."

Write-Host "To permanently add it to your PATH, run the following command in an elevated PowerShell prompt:"
Write-Host "setx PATH \"$($env:PATH)\""

Write-Host "Installation complete. (Terraform $NormalizedVersion)"

# Verify
Write-Host "Verifying terraform version..."
$versionOut = & $terraformExe -version
Write-Host $versionOut
