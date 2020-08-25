#----iam/output.tf----

output "iam_role_arn" {
  value = aws_iam_role.ecsTaskExecutionRole.arn
}