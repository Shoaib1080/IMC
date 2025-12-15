# IaC Tools Comparative Study: Terraform vs CloudFormation vs ARM Templates

## Overview
- Terraform: Multi-cloud, open-source, declarative HCL; provider ecosystem.
- CloudFormation: AWS-native, deep integration with AWS services; use for AWS-only environments.
- ARM Templates: Azure-native; declarative JSON templates and Bicep as a higher-level syntax.

## Strengths
- Terraform: Multi-cloud support, state management, modularization, community modules.
- CloudFormation: Native drift detection, StackSets, change sets, deeper resource coverage on AWS with native features.
- ARM/Bicep: First-class support for Azure constructs and tooling, policy integrations.

## Weaknesses
- Terraform: State management complexity for multiple teams; potential provider versioning.
- CloudFormation: AWS-only; complex JSON-based syntax; cross-account orchestration slightly more complex without additional tooling.
- ARM/Bicep: Azure-only.

## Use Cases
- Multi-cloud infra: Terraform
- AWS-native and heavily integrated features: CloudFormation
- Azure-specific resources: ARM/Bicep

## Conclusion
Choose Terraform for cross-cloud consistency and portability; use CloudFormation/ARM when relying on deep native features and policies within a single cloud.

