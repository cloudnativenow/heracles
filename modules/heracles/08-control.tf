# Control Elastic IP
resource "aws_eip" "control_eip" {
  instance = aws_instance.control.id
  vpc      = true
  # Use our common tags and add a specific name.
  tags = merge(
    local.common_tags,
    map(
      "Name", "${var.cluster_id}-control-eip"
    )
  )   
}

# Control Server
resource "aws_instance" "control" {
  ami                  = data.aws_ami.amazonlinux.id
  instance_type        = "t2.small"
  iam_instance_profile = aws_iam_instance_profile.heracles-control-instance-profile.id
  subnet_id            = aws_subnet.public-subnet.id

  vpc_security_group_ids = [
    aws_security_group.heracles-vpc.id,
    aws_security_group.heracles-ssh.id,
    aws_security_group.heracles-public-egress.id,
  ]

  //  Control Server Root Disk
  root_block_device {
    volume_size = 8
    volume_type = "gp2"
    tags = merge(
      local.common_tags,
      map(
        "Name", "${var.cluster_id}-control-root"
      )
    )    
  }  

  key_name = aws_key_pair.keypair.key_name

  # Use our common tags and add a specific name.
  tags = merge(
    local.common_tags,
    map(
      "Name", "${var.cluster_id}-control"
    )
  )
}
