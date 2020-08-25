# nat services output.tf

output "public_ip" {
  value = aws_eip.nat_eip.public_ip
}
