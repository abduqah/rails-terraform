#----rds/output.tf----

output "postgres_arn" {
  value = aws_db_instance.tf_postgres.arn
}

output "db_address" {
  value = aws_db_instance.tf_postgres.address
}

output "db_endpoint" {
  value = aws_db_instance.tf_postgres.endpoint
}

output "db_port" {
  value = aws_db_instance.tf_postgres.port
}
