locals {
  private_subnets = {
    for key, subnet in var.subnets :
    key => subnet
    if(lookup(subnet, "nat_gateway_subnet", null)) != null
  }
}

resource "aws_vpc" "main" {
  cidr_block = var.cidr_block

  tags = {
    Name = var.vpc_name
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.vpc_name}-igw"
  }
}

resource "aws_subnet" "subnets" {
  for_each                = var.subnets
  vpc_id                  = aws_vpc.main.id
  cidr_block              = each.value.cidr_block
  availability_zone       = each.value.availability_zone
  map_public_ip_on_launch = lookup(each.value, "nat_gateway_subnet", null) != null ? false : true

  tags = {
    Name = each.key
  }
}

# resource "aws_eip" "nat_ips" {
#   for_each = local.private_subnets
# }

# resource "aws_nat_gateway" "gateways" {
#   for_each = local.private_subnets

#   allocation_id = aws_eip.nat_ips[each.key].id
#   subnet_id     = aws_subnet.subnets[each.value.nat_gateway_subnet].id
# }

resource "aws_route_table" "route_tables" {
  for_each = var.subnets
  vpc_id   = aws_vpc.main.id

  tags = {
    Name = "${each.key}-route-table"
  }
}

resource "aws_route" "routes" {
  for_each = var.subnets

  route_table_id         = aws_route_table.route_tables[each.key].id
  destination_cidr_block = "0.0.0.0/0"

  gateway_id = aws_internet_gateway.main.id
  # gateway_id = lookup(each.value, "nat_gateway_subnet", null) == null ? aws_internet_gateway.main.id : null
  # nat_gateway_id = lookup(each.value, "nat_gateway_subnet", null) != null ? aws_nat_gateway.gateways[each.key].id : null

}

resource "aws_route_table_association" "associations" {
  for_each = var.subnets

  subnet_id      = aws_subnet.subnets[each.key].id
  route_table_id = aws_route_table.route_tables[each.key].id
}

resource "aws_security_group" "groups" {
  for_each = var.security_groups

  name   = each.key
  vpc_id = aws_vpc.main.id

  tags = {
    Name : each.key
  }
}

resource "aws_vpc_security_group_ingress_rule" "rules" {
  for_each = var.ingress_rules

  security_group_id = aws_security_group.groups[each.value.security_group_name].id
  cidr_ipv4         = each.value.cidr_ipv4
  from_port         = each.value.from_port
  ip_protocol       = each.value.ip_protocol
  to_port           = each.value.to_port
}


resource "aws_vpc_security_group_egress_rule" "rules" {
  for_each = var.egress_rules

  security_group_id = aws_security_group.groups[each.value.security_group_name].id
  cidr_ipv4         = each.value.cidr_ipv4
  from_port         = each.value.from_port
  ip_protocol       = each.value.ip_protocol
  to_port           = each.value.to_port
}
