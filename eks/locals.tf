locals {
  environment        = "development"
  availability_zones = ["eu-west-1a", "eu-west-1b"]
  eks_cluster_name   = "development-eks-cluster"
  eks_version        = "1.29"
}
