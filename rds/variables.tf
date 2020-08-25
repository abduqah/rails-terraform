#----rds/variables.tf----

variable "aws_resource_prefix" {}

variable "aws_resource_prefix_alphanumeric" {}

variable "vpc_security_group_ids" {
  type = list(string)
}

variable "db_instance_class" {
  default = "db.t2.medium"
}
variable "dbuser" {}
variable "dbname" {}
variable "dbpassword" {}
variable "rds_subnet_group_id" {}
