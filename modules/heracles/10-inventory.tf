//  Collect together all of the output variables needed to build to the final
//  inventory from the inventory template

resource "local_file" "inventory" {
 content = templatefile("inventory.template.cfg", {
      control-public_ip = aws_eip.control_eip.public_ip,
      nginx-public_ip = aws_eip.nginx_eip.public_ip,
      spring-public_ip = aws_eip.spring_eip.*.public_ip,
      mysql-public_ip = aws_eip.mysql_eip.public_ip
  }
 )
 filename = "inventory.cfg"
}