variable "name" { default = "aegis-dev" }
variable "region" { default = "us-west-2" }

module "vpc" {
  source           = "../../modules/vpc"
  name             = var.name
  cidr             = "10.20.0.0/16"
  azs              = ["us-west-2a","us-west-2b","us-west-2c"]
  public_subnets   = ["10.20.0.0/20","10.20.16.0/20","10.20.32.0/20"]
  private_subnets  = ["10.20.48.0/20","10.20.64.0/20","10.20.80.0/20"]
}

module "eks" {
  source           = "../../modules/eks"
  cluster_name     = var.name
  vpc_id           = module.vpc.vpc_id
  private_subnets  = module.vpc.private_subnets
  public_subnets   = module.vpc.public_subnets
  region           = var.region
}

data "aws_eks_cluster_auth" "this" {
  name = module.eks.cluster_name
}

# Note: Kubernetes and Helm providers will be configured after EKS cluster is created
# For now, comment out Karpenter module until cluster is ready

# module "karpenter" {
#   source           = "../../modules/karpenter"
#   cluster_name     = module.eks.cluster_name
#   cluster_endpoint = module.eks.cluster_endpoint
#   cluster_ca       = module.eks.cluster_ca
#   region           = var.region
# }