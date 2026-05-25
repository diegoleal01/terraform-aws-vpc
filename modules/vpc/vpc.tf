data "aws_availability_zones" "available_azs" {
  state = "available"
}

locals {
  azs = slice(data.aws_availability_zones.available_azs.names, 0, var.az_count)
}

resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = merge(
    var.tags,
    {
      Name = "vpc-${var.project_name}"
    }
  )
}

resource "aws_subnet" "private_subnet" {
  for_each          = toset(local.azs)
  vpc_id            = aws_vpc.this.id
  availability_zone = each.key

  cidr_block = cidrsubnet(aws_vpc.this.cidr_block, var.newbits_private_subnet, index(local.azs, each.key) + var.az_count)

  tags = merge(
    var.tags,
    {
      Name = "private-subnet-${each.key}"
    }
  )
}

resource "aws_subnet" "public_subnet" {
  for_each          = toset(local.azs)
  vpc_id            = aws_vpc.this.id
  availability_zone = each.key

  cidr_block = cidrsubnet(aws_vpc.this.cidr_block, var.newbits_public_subnet, index(local.azs, each.key))

  tags = merge(
    var.tags,
    {
      Name = "public-subnet-${each.key}"
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
  subnet_id     = aws_subnet.public_subnet[local.azs[0]].id
  allocation_id = aws_eip.this.id
  depends_on    = [aws_internet_gateway.this]

  tags = merge(
    var.tags,
    {
      Name = "nat-gateway-${var.project_name}"
    }
  )
}