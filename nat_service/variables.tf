# nat services variables.tf
variable "aws_resource_prefix" {}

variable "vpc_id" {}
variable "vpc_default_route_table_id" {}
variable "public_subnets" {
  type = list(string)
}
variable "private_subnets" {
  type = list(string)
}
