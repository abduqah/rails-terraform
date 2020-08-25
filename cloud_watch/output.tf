#----cloudWatch/output.tf----

output "logger_group_name" {
  value = aws_cloudwatch_log_group.logger.name
}
