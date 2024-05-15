output "public_ip" {
  value       = aws_eip.idream-jenkins-instance-eip.public_ip
  description = "The public IP address for IDream Jenkins instance"
}
