#----cache_services/output.tf----

output "redis_arn" {
  value = aws_elasticache_cluster.tf_redis.arn
}

output "redis_address" {
  value = aws_elasticache_cluster.tf_redis.cache_nodes.0.address
}

output "redis_port" {
  value = aws_elasticache_cluster.tf_redis.cache_nodes.0.port
}

output "redis_url" {
  value = "redis://${aws_elasticache_cluster.tf_redis.cache_nodes.0.address}:${aws_elasticache_cluster.tf_redis.cache_nodes.0.port}"
}
