output "instance_id" {
  description = "ID of the WordPress EC2 instance"
  value       = aws_instance.wordpress.id
}

output "public_ip" {
  description = "Public IPv4 address of the WordPress instance"
  value       = aws_instance.wordpress.public_ip
}

output "wordpress_url" {
  description = "Public WordPress endpoint"
  value       = "http://${aws_instance.wordpress.public_ip}"
}

output "security_group_id" {
  description = "ID of the WordPress security group"
  value       = aws_security_group.wordpress.id
}

