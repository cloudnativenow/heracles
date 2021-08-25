# Output some useful variables for quick SSH access etc.

output "control-public_ip" {
  value = aws_eip.control_eip.public_ip
}

output "nginx-public_ip" {
  value = aws_eip.nginx_eip.public_ip
}

output "spring-public_ip" {
  value = aws_eip.spring_eip.*.public_ip
}

output "mysql-public_ip" {
  value = aws_eip.mysql_eip.public_ip
}