#----lb/output.tf----

output "aws_lb_target_group_arn" {
  value = aws_lb_target_group.tf_target_group.arn
}
