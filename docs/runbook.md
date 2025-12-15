# Runbook: Provisioning and Configuration

## AWS Example
1. Export credentials

```powershell
$env:AWS_ACCESS_KEY_ID="..."
$env:AWS_SECRET_ACCESS_KEY="..."
$env:AWS_DEFAULT_REGION="us-east-1"
```

2. Initialize and plan

```powershell
cd terraform/aws
terraform init
terraform plan -var 'db_password=YourPassword'
terraform apply -var 'db_password=YourPassword' -auto-approve
```

3. Run Ansible for baseline config

```powershell
cd ../../ansible
ansible-playbook -i inventory.ini site.yml
```

## Notes
- Repeat similar steps for Azure (az login) and GCP (gcloud auth application-default login).
- Ensure credentials are stored securely in CI pipeline secrets.

## Using repo-local tools (no admin)
If you don’t have or cannot install global tools on your workstation, use the repo-local tool helpers:

```powershell
# Install terraform to repo local ./tools folder
.\scripts\install-terraform.ps1 -Version latest

# Add to current session path
.\scripts\activate-tools.ps1
terraform -version
```

If you intend to install Terraform system-wide instead, install with Chocolatey or Scoop in an elevated shell.

## Installing Terraform (Windows)

If `terraform` is not recognized in PowerShell, install Terraform with one of the options below:

- Chocolatey

```powershell
choco install terraform -y
```

- Scoop

```powershell
scoop install terraform
```

- Using the repository helper

```powershell
cd C:\Users\user\infra-multicloud
.\scripts\install-terraform.ps1 -Version latest
# add to current session PATH
$env:PATH = "$PWD\tools\terraform;$env:PATH"
terraform -version
```

If you need to add to PATH permanently, use an elevated PowerShell prompt to run `setx`, e.g.:

```powershell
setx PATH "$env:PATH;C:\Users\user\infra-multicloud\tools\terraform"
```
