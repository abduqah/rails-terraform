#----root/variables.tf----

variable "aws_resource_prefix" {}
variable "aws_resource_prefix_alphanumeric" {}

variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "aws_account_id" {}
variable "aws_region" {
  default     = "us-east-2"
  description = "AWS region e.g. us-east-1 (Please specify a region supported by the Fargate launch type)"
}

variable "vpc_cidr" {}

variable "public_cidrs" {
  type = list(string)
}

variable "private_cidrs" {
  type = list(string)
}

variable "accessip" {}

variable "elasticache_cluster_id" {}

variable "db_instance_class" {
  default = "db.t2.medium"
}
variable "dbname" {}
variable "dbuser" {}
variable "dbpassword" {}
variable "ec_instance_node_type" {
  default =  "cache.t2.medium"
}

variable "instances_number" {
  default = 1
}
