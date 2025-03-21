resource "aws_vpn_gateway" "this" {
  vpc_id = var.vpc_id

  tags = merge(
    var.tags,
    {
      Name = "vpn-gateway-${var.project_name}"
    }
  )
}

resource "aws_customer_gateway" "this" {
  bgp_asn    = 65000
  ip_address = var.office_external_gateway_ip
  type       = "ipsec.1"

  tags = merge(
    var.tags,
    {
      Name = var.office_cgw_name
    }
  )
}

resource "aws_vpn_connection" "this" {
  vpn_gateway_id      = aws_vpn_gateway.this.id
  customer_gateway_id = aws_customer_gateway.this.id
  type                = "ipsec.1"
  static_routes_only  = true

  tags = merge(
    var.tags,
    {
      Name = "vpn-office-${var.project_name}"
    }
  )
}

resource "aws_vpn_gateway_route_propagation" "public_route_propagation" {
  vpn_gateway_id = aws_vpn_gateway.this.id
  route_table_id = var.public_rtb_id
}

resource "aws_vpn_gateway_route_propagation" "private_route_propagation" {
  vpn_gateway_id = aws_vpn_gateway.this.id
  route_table_id = var.private_rtb_id
}

resource "aws_vpn_connection_route" "this" {
  destination_cidr_block = var.office_lan_cidr_block
  vpn_connection_id      = aws_vpn_connection.this.id
}