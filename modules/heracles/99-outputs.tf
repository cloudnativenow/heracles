# Output some useful variables for quick SSH access etc.

output "bastion-public_ip" {
  value = aws_eip.bastion_eip.public_ip
}

output "node1-public_ip" {
  value = {aws_eip.node1_eip.public_ip
}