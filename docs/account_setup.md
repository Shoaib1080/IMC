# Multi-Cloud Account Setup (Free Tiers)

This guide helps create free-tier accounts on AWS, Azure, and GCP.

## AWS
- Create an account at https://aws.amazon.com/
- Free tier includes 12 months of certain compute and storage resources; register with a credit card.
- Recommended IAM setup: create an admin user, use MFA.

## Azure
- Create an account at https://azure.microsoft.com/
- New users get $200 credit for 30 days and certain free services for 12 months.
- Use Azure AD for RBAC; set up subscription and resource group.

## GCP
- Create an account at https://cloud.google.com/
- New users get $300 credit and many always-free resources.
- Enable required APIs and create a service account for Terraform with appropriate roles.

## Security
- Create IAM/service accounts for automation with least-privilege.
- Store credentials in a secure secrets store (Azure Key Vault, AWS Secrets Manager, GCP Secret Manager, or GitHub Secrets for CI/CD).

## Next Steps
- Provide Terraform and Ansible examples to connect to the cloud accounts and provision resources.
