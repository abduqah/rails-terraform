#----subnets/main.tf----

variable "aws_resource_prefix" {}

variable "vpc_id" {}

variable "public_cidrs" {
  type = list(string)
}

variable "private_cidrs" {
  type = list(string)
}
