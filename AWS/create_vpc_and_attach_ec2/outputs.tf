output "vpc_id" {
  value = aws_vpc.my_vpc.id
}

output "public_subnet_id" {
  value = aws_subnet.public_subnet.id
}

output "private_subnet_id" {
  value = aws_subnet.private_subnet.id
}

output "ec2_instance_id" {
  value = aws_instance.my_ec2.id
}
output "ec2_public_ip" {
  value = aws_instance.my_ec2.public_ip
}

