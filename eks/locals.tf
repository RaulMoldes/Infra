locals {
  environment        = "development"
  availability_zones = ["eu-west-2a", "eu-west-2b"]
  eks_cluster_name   = "development-eks-cluster"
  eks_version        = "1.29"
}
