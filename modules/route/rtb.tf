resource "aws_route_table" "public_rtb" {
  vpc_id = var.vpc_id

  tags = merge(
    var.tags,
    {
      Name = "public-rtb-${var.project_name}"
    }
  )

  route {
    cidr_block = var.default_route
    gateway_id = var.igw_id
  }
}

resource "aws_route_table" "private_rtb" {
  vpc_id = var.vpc_id

  tags = merge(
    var.tags,
    {
      Name = "private-rtb-${var.project_name}"
    }
  )

  route {
    cidr_block = var.default_route
    gateway_id = var.ngw_id
  }
}

resource "aws_main_route_table_association" "this" {
  vpc_id         = var.vpc_id
  route_table_id = aws_route_table.private_rtb.id
}

resource "aws_route_table_association" "private_rtb_association" {
  for_each       = var.private_subnet_id
  subnet_id      = each.value
  route_table_id = aws_route_table.private_rtb.id
}

resource "aws_route_table_association" "public_rtb_association" {
  for_each       = var.public_subnet_id
  subnet_id      = each.value
  route_table_id = aws_route_table.public_rtb.id
}