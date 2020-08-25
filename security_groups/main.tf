#----security_groups/main.tf----

resource "aws_security_group" "default" {
  name = "${var.aws_resource_prefix}-default-sg"
  description = "Default security group to allow inbound/outbound from the VPC"
  vpc_id = var.vpc_id
  ingress {
    from_port = "0"
    to_port = "0"
    protocol = "-1"
    self = true
  }
  egress {
    from_port = "0"
    to_port = "0"
    protocol = "-1"
    self = "true"
  }
}

resource "aws_security_group" "db_access_sg" {
  vpc_id      = var.vpc_id
  name        = "${var.aws_resource_prefix}-db-access-sg"
  description = "Allow access to RDS"
  tags = {
    Name = "${var.aws_resource_prefix}-db-access-sg"
  }
}


resource "aws_security_group" "rds_sg" {
  name        = "${var.aws_resource_prefix}-rds-sg"
  description = "${var.aws_resource_prefix} Security Group"
  vpc_id      = var.vpc_id
  tags = {
    Name = "${var.aws_resource_prefix}-rds-sg"
  }// allows traffic from the SG itself
  ingress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    self = true
  }//allow traffic for TCP 5432
  ingress {
    from_port = 5432
    to_port = 5432
    protocol = "tcp"
    security_groups = [aws_security_group.db_access_sg.id]
  }// outbound internet access
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks= ["0.0.0.0/0"]
  }
}


resource "aws_security_group" "web_inbound_sg" {
  name        = "${var.aws_resource_prefix}-web-inbound-sg"
  description = "Allow HTTP from Anywhere into ALB"
  vpc_id      = var.vpc_id
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 8
    to_port = 0
    protocol = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "${var.aws_resource_prefix}-web-inbound-sg"
  }
}

resource "aws_security_group" "ecs_service" {
  vpc_id      = var.vpc_id
  name        = "${var.aws_resource_prefix}-ecs-service-sg"
  description = "Allow egress from container"
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 8
    to_port = 0
    protocol = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "${var.aws_resource_prefix}-ecs-service-sg"
  }
}
