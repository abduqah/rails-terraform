#----lb/variables.tf----

variable "aws_resource_prefix" {}
variable "public_sg" {
  type    = list(string)
  default = [""]
}
variable "vpc_id" {}
variable "public_subnets" {}
