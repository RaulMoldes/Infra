resource "aws_eip" "nat_elastic_ip" {
  domain = "vpc"
  tags = {
    Name = "${local.environment}-eks-nat-eip"
  }
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_elastic_ip.id
  subnet_id     = aws_subnet.public_subnet1.id
  tags = {
    Name = "${local.environment}-eks-nat-gateway"
  }
  depends_on = [aws_internet_gateway.igw]
}
