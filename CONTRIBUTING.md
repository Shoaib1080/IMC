# Contributing

Thanks for contributing. Steps to run local checks:

- Run unit tests:

```powershell
cd app
python -m pytest
```

- Validate Terraform:

```powershell
cd terraform/aws
terraform init
terraform validate
```
Note: If `terraform` isn't installed or not in your PATH, follow the steps below to install Terraform on Windows or use the helper script in the repo.

Quick install options (Windows):

- Using Chocolatey (recommended if you have choco):

```powershell
choco install terraform -y
```

- Using Scoop (if installed):

```powershell
scoop install terraform
```

- Manual (helper script included):

```powershell
# download and add terraform to ./tools/terraform for this repo
.\scripts\install-terraform.ps1 -Version latest
# add tools folder to your PATH for the current session
$env:PATH = "$PWD\tools\terraform;$env:PATH"
terraform -version
```

### Helper scripts
The repository includes helper scripts in `scripts/` to simplify setup and cleanup tasks:

- `scripts/install-terraform.ps1`: download Terraform into `./tools/terraform` in this repo.
- `scripts/activate-tools.ps1`: add repo `tools/*` directories to PATH for current shell session.
- `scripts/cleanup-choco-locks.ps1`: interactive script to clean Chocolatey lock/partial install directories (requires Admin privileges).

To temporarily add repo local tools to PATH for this session:

```powershell
.\scripts\activate-tools.ps1
terraform -version
```

To safely clean up Chocolatey leftover locks (Admin):

```powershell
# Run in elevated shell
Start-Process PowerShell -Verb RunAs
.\scripts\cleanup-choco-locks.ps1
```

- Run Ansible playbooks against a test host (add to inventory):

```powershell
ansible-playbook -i ansible/inventory.ini ansible/site.yml
```

- Run CI pipeline locally with act (for GitHub Actions) or Jenkins pipeline by adding to a Jenkins job.
