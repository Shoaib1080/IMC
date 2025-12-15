provider "aws" {
  region = var.region
}

module "vpc" {
  source = "./vpc"
  name   = var.name
}

module "eks" {
  source       = "./eks"
  cluster_name = var.name
  vpc_id       = module.vpc.vpc_id
  subnet_ids   = module.vpc.private_subnets
}

module "storage" {
  source      = "./storage"
  bucket_name = "${var.name}-bucket-001"
  db_name     = "${var.name}_db"
  username    = "dbadmin"
  password    = var.db_password
  subnet_ids  = module.vpc.private_subnets
}
