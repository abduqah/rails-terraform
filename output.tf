#----root/output.tf----

output "repo_url" {
  value = module.ecr_service.repo_url
}

output "db_address" {
  value = module.rds.db_address
}

output "db_port" {
  value = module.rds.db_port
}

output "redis_address" {
  value = module.cache_services.redis_address
}

output "redis_url" {
  value = module.cache_services.redis_url
}

output "redis_port" {
  value = module.cache_services.redis_port
}

output "public_ip" {
  value = module.nat.public_ip
}

output "db_url" {
  value = "postgresql://${module.rds.db_endpoint}"
}
