#----ecr service/output.tf----

output "repo_url" {
  value = aws_ecr_repository.tf_repository.repository_url
}