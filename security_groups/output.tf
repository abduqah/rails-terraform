#----security_groups/output.tf----

output "rds_sg" {
  value = aws_security_group.rds_sg.id
}

output "web_inbound_sg" {
  value = aws_security_group.web_inbound_sg.id
}

output "ecs_service" {
  value = aws_security_group.ecs_service.id
}

output "security_groups_ids" {
  value = [aws_security_group.default.id, aws_security_group.db_access_sg.id]
}

output "lb_security_groups_ids" {
  value = [aws_security_group.default.id, aws_security_group.db_access_sg.id, aws_security_group.web_inbound_sg.id]
}

output "ecs_security_groups_ids" {
  value = [aws_security_group.default.id, aws_security_group.db_access_sg.id, aws_security_group.ecs_service.id]
}
