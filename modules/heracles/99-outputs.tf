# Output some useful variables for quick SSH access etc.

output "control-public_ip" {
  value = aws_eip.control_eip.public_ip
}

output "control-private_ip" {
  value = aws_instance.control.private_ip
}

output "nginx-public_ip" {
  value = aws_eip.nginx_eip.public_ip
}

output "nginx-private_ip" {
  value = aws_instance.nginx.private_ip
}

output "spring-public_ip" {
  value = aws_eip.spring_eip.*.public_ip
}

output "spring-private_ip" {
  value = aws_instance.spring.*.private_ip
}

output "mysql-public_ip" {
  value = aws_eip.mysql_eip.public_ip
}

output "mysql-private_ip" {
  value = aws_instance.mysql.private_ip
}

