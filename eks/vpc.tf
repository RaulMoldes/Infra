

resource "aws_vpc" "eks_main_vpc" {
  cidr_block = "10.0.0.0/16"

  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name        = "${local.environment}-eks-main-vpc"
    Description = "Main VPC for my EKS cluster"
  }
}


resource "aws_subnet" "private_subnet1" {
  vpc_id            = aws_vpc.eks_main_vpc.id
  cidr_block        = "10.0.0.0/19"
  availability_zone = local.availability_zones[0]

  tags = {
    Name                                              = "${local.environment}-private-subnet-1"
    Description                                       = "Private subnet for my EKS cluster"
    "kubernetes.io/role/internal-elb"                 = "1"
    "kubernetes.io/cluster/${local.eks_cluster_name}" = "owned"
  }

}


resource "aws_subnet" "private_subnet2" {
  vpc_id            = aws_vpc.eks_main_vpc.id
  cidr_block        = "10.0.32.0/19"
  availability_zone = local.availability_zones[1]

  tags = {
    Name                                              = "${local.environment}-eks-private_subnet-2"
    Description                                       = "Private subnet for my EKS cluster"
    "kubernetes.io/role/internal-elb"                 = "1"
    "kubernetes.io/cluster/${local.eks_cluster_name}" = "owned"
  }

}

resource "aws_subnet" "public_subnet1" {
  vpc_id                  = aws_vpc.eks_main_vpc.id
  cidr_block              = "10.0.64.0/19"
  availability_zone       = local.availability_zones[0]
  map_public_ip_on_launch = true
  tags = {
    Name                                              = "${local.environment}-public-subnet-1"
    Description                                       = "Public subnet for my EKS cluster"
    "kubernetes.io/role/elb"                          = "1"
    "kubernetes.io/cluster/${local.eks_cluster_name}" = "owned"
  }

}

resource "aws_subnet" "public_subnet2" {
  vpc_id                  = aws_vpc.eks_main_vpc.id
  cidr_block              = "10.0.96.0/19"
  availability_zone       = local.availability_zones[1]
  map_public_ip_on_launch = true
  tags = {
    Name                                              = "${local.environment}-public-subnet-2"
    Description                                       = "Public subnet for my EKS cluster"
    "kubernetes.io/role/elb"                          = "1"
    "kubernetes.io/cluster/${local.eks_cluster_name}" = "owned"
  }

}
