# Output some useful variables for quick SSH access etc.

output "control-public_ip" {
  value = aws_eip.control_eip.public_ip
}

output "node-public_ip" {
  value = aws_eip.node_eip.*.public_ip
}