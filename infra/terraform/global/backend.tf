terraform {
  required_version = ">= 1.6"
  backend "s3" {}
required_providers {
  aws         = { source = "hashicorp/aws",        version = "5.58.0" }
  helm        = { source = "hashicorp/helm",       version = "2.13.2" }
  kubernetes  = { source = "hashicorp/kubernetes", version = "2.29.0" }
  time        = { source = "hashicorp/time",       version = "0.13.1" }
}
}