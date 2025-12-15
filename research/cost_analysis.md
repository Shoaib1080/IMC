# Multi-cloud Cost Analysis Framework

This document outlines how to estimate and compare the cost of identical infrastructure on AWS / Azure / GCP.

## Steps
1. Define identical infrastructure components:
   - VPC, 2 public subnets, 2 private subnets
   - Kubernetes cluster (small nodes) with 2 worker nodes
   - Database (single small instance)
   - Block/object storage (20 GB)
2. Use cloud pricing calculators (AWS Pricing Calculator, Azure Pricing Calculator, GCP Pricing Calculator) to estimate monthly costs for compute, storage, networking.
3. Include operational costs such as load balancer, NAT gateway, egress traffic.

## Notes
- Some services have price differences by region.
- Managed offerings (AKS/EKS/GKE) have different pricing models (control plane cost may differ).
- Add examples in a CSV or spreadsheet for precise comparisons.

## Next Steps
- Provide a spreadsheet with a per-service cost breakdown and assumptions.
