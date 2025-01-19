output "public_ip" {

  description = "Value of the public IP address of the EC2 instance"
  value       = aws_instance.SingleServer.public_ip

  sensitive = false
}
