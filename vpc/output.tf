#----vpc/output.tf----

output "vpc_id" {
  value = aws_vpc.tf_vpc.id
}

output "default_route_table_id" {
  value = aws_vpc.tf_vpc.default_route_table_id
}
