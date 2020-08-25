#----cloudWatch/main.tf----
resource "aws_cloudwatch_log_group" "logger" {
  name = var.aws_resource_prefix
}
