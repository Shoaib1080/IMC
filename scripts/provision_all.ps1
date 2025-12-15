# PowerShell helper to provision subfolders' Terraform
$clouds = @('aws','azure','gcp')
foreach ($cloud in $clouds) {
  Write-Host "Provisioning $cloud..."
  Push-Location "terraform/$cloud"
  terraform init
  terraform plan
  # terraform apply -auto-approve # Uncomment to apply
  Pop-Location
}
