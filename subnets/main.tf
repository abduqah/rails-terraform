#----subnets/main.tf----

data "aws_availability_zones" "available" {}

resource "aws_subnet" "public_subnet" {
  count                   = 2
  vpc_id                  = var.vpc_id
  cidr_block              = var.public_cidrs[count.index]
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name = "${var.aws_resource_prefix}_public_${count.index + 1}"
  }
}

resource "aws_subnet" "private_subnet" {
  count                   = 2
  vpc_id                  = var.vpc_id
  cidr_block              = var.private_cidrs[count.index]
  map_public_ip_on_launch = false
  availability_zone       = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name = "${var.aws_resource_prefix}_private_${count.index + 1}"
  }
}

resource "aws_db_subnet_group" "rds_subnet_group" {
  name        = "${var.aws_resource_prefix}-rds-subnet-group"
  description = "RDS subnet group"
  subnet_ids  = [
    for instance in aws_subnet.private_subnet:
      instance.id
  ]
}
