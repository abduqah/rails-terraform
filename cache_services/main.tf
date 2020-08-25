#----cache_services/main.tf----

# create redis instance
resource "aws_elasticache_cluster" "tf_redis" {
  cluster_id           = var.elasticache_cluster_id
  engine               = "redis"
  node_type            = var.ec_instance_node_type
  num_cache_nodes      = 1
  parameter_group_name = "default.redis3.2"
  engine_version       = "3.2.10"
  port                 = 6379
  subnet_group_name    = aws_elasticache_subnet_group.elasticache_subnet.name

  tags                 = {
    name = "${var.aws_resource_prefix}_redis"
  }
}

resource "aws_elasticache_subnet_group" "elasticache_subnet" {
  name       = "${var.aws_resource_prefix}-cache-subnet"
  subnet_ids = var.private_subnets
}
