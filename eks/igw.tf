resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.eks_main_vpc.id

  tags = {
    Name = "${local.environment}-eks-main-igw"
  }
}
