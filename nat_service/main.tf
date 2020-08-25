# nat services main.tf

resource "aws_eip" "nat_eip" {
 vpc        = true
 depends_on = [aws_internet_gateway.ig]
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id  = var.public_subnets[0]
  depends_on = [aws_internet_gateway.ig]
  tags       = {
    Name = "${var.aws_resource_prefix}-nat"
  }
}

resource "aws_internet_gateway" "ig" {
  vpc_id = var.vpc_id
  tags   = {
    Name = "${var.aws_resource_prefix}_igw"
  }
}

resource "aws_route_table" "private" {
  vpc_id = var.vpc_id
  tags   = {
    Name = "${var.aws_resource_prefix}-private-route-table"
  }
}


resource "aws_route_table" "public" {
  vpc_id = var.vpc_id
  tags   = {
    Name = "${var.aws_resource_prefix}-public-route-table"
  }
 }


resource "aws_route" "public_internet_gateway" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.ig.id
}


resource "aws_route" "private_nat_gateway" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat.id
}


resource "aws_route_table_association" "public" {
  count          = length(var.public_subnets)
  subnet_id      = var.public_subnets[count.index]
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private" {
  count          = length(var.private_subnets)
  subnet_id      = var.private_subnets[count.index]
  route_table_id = aws_route_table.private.id
}