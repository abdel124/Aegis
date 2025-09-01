module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.8"

  cluster_name    = var.cluster_name
  cluster_version = "1.29"
  vpc_id          = var.vpc_id
  subnet_ids      = var.private_subnets

  enable_irsa = true
  
  # Enable cluster logging
  cluster_enabled_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]

  eks_managed_node_groups = {
    default = {
      desired_size   = 2
      max_size       = 5
      min_size       = 2
      instance_types = ["m6i.large"]
      capacity_type  = "ON_DEMAND"
      
      labels = {
        role = "worker"
      }
      
      tags = {
        Name = "${var.cluster_name}-worker"
      }
    }
  }

  cluster_addons = {
    coredns                = { most_recent = true }
    kube-proxy             = { most_recent = true }
    vpc-cni                = { most_recent = true }
    eks-pod-identity-agent = { most_recent = true }
  }
  
  tags = {
    Environment = "dev"
    Project     = "aegis"
  }
}
