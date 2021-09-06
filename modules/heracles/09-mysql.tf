//  Create the MySQL userdata script.
data "template_file" "setup-mysql" {
  template = file("${path.module}/files/setup-mysql.sh")
  vars = {
    availability_zone = "${data.aws_availability_zones.azs.names[0]}"
    log_stream_name = "${var.cluster_id}-mysql"
    region = "${var.region}"
  }
}

# MySQL Elastic IP
resource "aws_eip" "mysql_eip" {
  instance = aws_instance.mysql.id
  vpc      = true
  # Use our common tags and add a specific name.
  tags = merge(
    local.common_tags,
    map(
      "Name", "${var.cluster_id}-mysql-eip"
    )
  )   
}

# NGINX Server
resource "aws_instance" "mysql" {
  ami                  = data.aws_ami.amazonlinux.id
  instance_type        = var.amisize
  iam_instance_profile = aws_iam_instance_profile.heracles-mysql-instance-profile.id
  user_data            = data.template_file.setup-mysql.rendered
  subnet_id            = aws_subnet.public-subnet.id

  vpc_security_group_ids = [
    aws_security_group.heracles-vpc.id,
    aws_security_group.heracles-ssh.id,
    aws_security_group.heracles-public-egress.id,
  ]

  //  NGINX Server Root Disk
  root_block_device {
    volume_size = 8
    volume_type = "gp2"
    tags = merge(
      local.common_tags,
      map(
        "Name", "${var.cluster_id}-mysql-root"
      )
    )    
  }  

  key_name = aws_key_pair.keypair.key_name

  # Use our common tags and add a specific name.
  tags = merge(
    local.common_tags,
    map(
      "Name", "${var.cluster_id}-mysql"
    )
  )
}
