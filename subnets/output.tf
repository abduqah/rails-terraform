#----subnets/output.tf----

output "public_subnet_ids" {
  value = [
    for instance in aws_subnet.public_subnet:
      instance.id
  ]
}

output "private_subnet_ids" {
  value = [
    for instance in aws_subnet.private_subnet:
      instance.id
  ]
}

output "rds_subnet_group_id" {
  value = aws_db_subnet_group.rds_subnet_group.id
}

# output "public_subnet_cidrs" {
#   value = [aws_subnet.public_subnet.*.cidr_block]
# }

# output "private_subnets_ips" {
#   value = [aws_subnet.private_subnet.*.id]
# }

# output "public_subnets_ips" {
#   value = [aws_subnet.public_subnet.*.id]
# }

# output "private_subnet_cidrs" {
#   value = [aws_subnet.private_subnet.*.cidr_block]
# }
