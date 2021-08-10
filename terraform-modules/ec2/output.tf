output "ec2_dns" {
  value = aws_instance.ec2.public_dns
}

output "ec2_ip" {
  value = aws_instance.ec2.public_ip
}

output "ec2_sg_id" {
  value = aws_security_group.ec2.id
}
