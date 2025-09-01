variable "cluster_name" {}
variable "vpc_id" {}
variable "private_subnets" { type = list(string) }
variable "public_subnets" { type = list(string) }
variable "region" { default = "us-west-2" }