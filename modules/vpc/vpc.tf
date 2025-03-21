resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = var.vpc_dns_hostnames
  enable_dns_support   = var.vpc_dns_support

  tags = merge(
    var.tags,
    {
      Name = "vpc-${var.project_name}"
    }
  )
}

resource "aws_subnet" "private_subnet" {
  for_each          = var.private_subnet_numbers
  vpc_id            = aws_vpc.this.id
  availability_zone = each.key

  cidr_block = cidrsubnet(aws_vpc.this.cidr_block, var.newbits_private_subnet, each.value)

  tags = merge(
    var.tags,
    {
      Name = "private-subnet-${each.key}"
      # Uncomment and modify as needed when creating the VPC for use with EKS
      # "kubernetes.io/cluster/<cluster_name>" = "owned"
      # "kubernetes.io/role/internal-elb" = 1
    }
  )
}

resource "aws_subnet" "public_subnet" {
  for_each          = var.public_subnet_numbers
  vpc_id            = aws_vpc.this.id
  availability_zone = each.key

  cidr_block = cidrsubnet(aws_vpc.this.cidr_block, var.newbits_public_subnet, each.value)

  tags = merge(
    var.tags,
    {
      Name = "public-subnet-${each.key}"
      # Uncomment and modify as needed when creating the VPC for use with EKS
      # "kubernetes.io/cluster/<cluster_name>" = "owned"
      # "kubernetes.io/role/elb"          = 1
    }
  )
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = merge(
    var.tags,
    {
      Name = "internet-gateway-${var.project_name}"
    }
  )
}

resource "aws_eip" "this" {

  tags = merge(
    var.tags,
    {
      Name = "ngw-eip-${var.project_name}"
    }
  )
}

resource "aws_nat_gateway" "this" {
  subnet_id     = var.ngw_public_subnet_id
  allocation_id = aws_eip.this.id

  tags = merge(
    var.tags,
    {
      Name = "nat-gateway-${var.project_name}"
    }
  )
}