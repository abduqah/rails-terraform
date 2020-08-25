#----ecs/variables.tf----

variable "aws_resource_prefix" {}
variable "repository_url" {}
variable "iam_role_arn" {}
variable "aws_lb_target_group_arn" {}
variable "public_subnets" {}
variable "public_sg" {
  type = list(string)
}
variable "instances_number" {}
variable "aws_region" {}
variable "logger_group" {}
