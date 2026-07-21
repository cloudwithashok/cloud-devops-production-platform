output "instance_id" {
    description = "EC2 Instance_ID"
    value = aws_instance.production_server.id

  
}
output "public_ip" {
    description = "EC2 Public IP"
    value = aws_instance.production_server.public_ip
}

output "public_dns" {
    description = "EC2 Public DNS"
    value = aws_instance.production_server.public_dns
  
}