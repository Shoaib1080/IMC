# Artifact Management Strategy

This document outlines an artifact management strategy for the multi-cloud infra project.

Options:

- GitHub Packages (GHCR) – recommended for GitHub-hosted source. Easier integration with Actions and access control.
- AWS ECR – good for deploying into AWS/EKS directly.
- Azure Container Registry – integrated with Azure AD and AKS.
- GCR/Artifact Registry – best for GCP deployments.
- Nexus/Artifactory – centralized option for enterprises, stores images, binaries and more.

Recommendation:
- Use GitHub Container Registry for CI tests and central storage; mirror/push to cloud-provider registries (ECR/ACR/GCR) when deploying to each target environment for faster pulls and network locality.

Retention & Security:
- Enable retention policies for images.
- Scan images on build (e.g., Trivy) and block builds with high-severity findings.
- Use signed images where possible.

Integrations:
- CI/CD pipeline should build the image, scan, run tests, and push to the chosen registry. For deployments, use Terraform or provider-specific tooling to point to the correct registry and repository.
