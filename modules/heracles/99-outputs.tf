# Output some useful variables for quick SSH access etc.

output "bastion-public_ip" {
  value = aws_eip.bastion_eip.public_ip
}

output "node-public_ip" {
  value = aws_eip.node_eip.*.public_ip
}