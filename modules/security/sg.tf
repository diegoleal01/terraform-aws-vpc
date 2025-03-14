resource "aws_security_group" "office_sg" {
  vpc_id      = var.vpc_id
  name        = var.office_access_sg_name
  description = "Office access"

  tags = merge(
    var.tags,
    {
      Name = var.office_access_sg_name
    }
  )

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.office_cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.default_route]
  }
}

resource "aws_security_group" "vpc_sg" {
  vpc_id      = var.vpc_id
  name        = var.vpc_access_sg_name
  description = "VPC internal traffic"

  tags = merge(
    var.tags,
    {
      Name = var.vpc_access_sg_name
    }
  )

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.vpc_cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.default_route]
  }
}