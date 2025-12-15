# AWS VPC module

This module creates a basic VPC with public and private subnets, an internet gateway, and public route table.

Example usage:

```hcl
module "vpc" {
  source         = "../modules/aws/vpc"
  name           = "test"
  vpc_cidr       = "10.1.0.0/16"
  public_subnets = ["10.1.1.0/24","10.1.2.0/24"]
  private_subnets = ["10.1.10.0/24","10.1.11.0/24"]
}
```

Note: Adapt AZs and tags as needed.
