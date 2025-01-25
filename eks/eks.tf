resource "aws_iam_role" "eks" {
  name               = "${local.environment}-eks-cluster-role"
  assume_role_policy = <<POLICY
    {
    "Version": "2012-10-17",
    "Statement": [
        {
        "Effect": "Allow",
        "Principal": {
            "Service": "eks.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
        }
    ]
}
POLICY
}

resource "aws_iam_policy_attachment" "eks" {
  name       = "${local.environment}-eks-cluster-policy-attachment"
  roles      = [aws_iam_role.eks.name]
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}



resource "aws_eks_cluster" "eks" {
  name     = local.eks_cluster_name
  role_arn = aws_iam_role.eks.arn
  version  = local.eks_version

  vpc_config {
    endpoint_private_access = false
    endpoint_public_access  = true
    subnet_ids = [
      aws_subnet.private_subnet1.id,
      aws_subnet.private_subnet2.id,
    ]
    
  }

  access_config {
    authentication_mode = "API"
    bootstrap_cluster_creator_admin_permissions = true
  }
  depends_on = [
    aws_iam_policy_attachment.eks
  ]
  tags = {
    Name = local.eks_cluster_name
  }
}
