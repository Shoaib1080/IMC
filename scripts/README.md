# Scripts

This folder contains helper scripts to streamline local developer setup and cleanup tasks.

Scripts:

- `install-terraform.ps1` – Download Terraform into `./tools/terraform`. Intended for non-admin environments where Chocolatey isn't available.
- `activate-tools.ps1` – Add repo `./tools/*` tool directories to the current PowerShell session's PATH.
- `cleanup-choco-locks.ps1` – Interactive script for Admins to remove Chocolatey lock directories left by failed installs.

Common usage:

```powershell
# Download Terraform to ./tools/terraform
.
\scripts\install-terraform.ps1 -Version latest

# Add local tools to PATH for this session and check terraform
.
\scripts\activate-tools.ps1
terraform -version
```

Admin only:

```powershell
Start-Process PowerShell -Verb RunAs
.\scripts\cleanup-choco-locks.ps1
```
