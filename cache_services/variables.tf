#----cache_services/variables.tf----

variable "aws_resource_prefix" {}

variable "elasticache_cluster_id" {}

variable "ec_instance_node_type" {
  default =  "cache.t2.medium"
}

variable "private_subnets" {
  type = list(string)
}

variable "vpc_security_group_ids" {
  type = list(string)
}
