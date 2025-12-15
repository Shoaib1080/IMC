# AWS EKS Module

Provides a simple EKS cluster and managed node group.

Inputs:
- cluster_name
- vpc_id
- subnet_ids
- node_group_count

Outputs:
- cluster_endpoint
- cluster_name
- node_group_arn

Example:
```hcl
module "eks" {
  source = "./eks"
  cluster_name = "demo-eks"
  vpc_id = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets
}
```
