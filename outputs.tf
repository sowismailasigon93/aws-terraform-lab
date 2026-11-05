output "instance_id" {
  value = aws_instance.app.id
}

output "private_ip" {
  value = aws_instance.app.private_ip
}

output "ssm_command" {
  description = "Connexion sans SSH ni port ouvert"
  value       = "aws ssm start-session --target ${aws_instance.app.id}"
}
