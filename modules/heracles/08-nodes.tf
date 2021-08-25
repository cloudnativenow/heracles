//  Create the node userdata script.
data "template_file" "setup-node" {
  template = file("${path.module}/files/setup-node.sh")
  vars = {
    availability_zone = "${data.aws_availability_zones.azs.names[0]}"
    log_stream_name = "${var.cluster_id}-node-${count.index + 1}"
  }
}

// Create Elastic IPs for the Nodes
resource "aws_eip" "node_eip" {
  instance = element(aws_instance.node.*.id,count.index)
  count = var.instance_count
  vpc   = true
  # Use our common tags and add a specific name.
  tags = merge(
    local.common_tags,
    map(
      "Name", "${var.cluster_id}-node-${count.index + 1}-eip"
    )
  )  
}

// Create Nodes
resource "aws_instance" "node" {
  count                = var.instance_count
  ami                  = data.aws_ami.amazonlinux.id
  instance_type        = var.amisize
  subnet_id            = aws_subnet.public-subnet.id
  iam_instance_profile = aws_iam_instance_profile.heracles-instance-profile.id
  user_data            = data.template_file.setup-node.rendered

  vpc_security_group_ids = [
    aws_security_group.heracles-vpc.id,
    aws_security_group.heracles-ssh.id,    
    aws_security_group.heracles-public-ingress.id,
    aws_security_group.heracles-public-egress.id,
  ]

  //  Node Root Disk
  root_block_device {
    volume_size = 8
    volume_type = "gp2"
    tags = merge(
      local.common_tags,
      map(
        "Name", "${var.cluster_id}-node-${count.index + 1}-root"
      )
    )    
  }

  # Node Data Disk
  # ebs_block_device {
  #   device_name = "/dev/sdf"
  #   volume_size = 16
  #   volume_type = "gp2"
  #   tags = merge(
  #     local.common_tags,
  #     map(
  #       "Name", "${var.cluster_id}-node-${count.index + 1}-data"
  #     )
  #   )     
  # }

  key_name = aws_key_pair.keypair.key_name

  //  Use our common tags and add a specific name.
  tags = merge(
    local.common_tags,
    map(
      "Name", "${var.cluster_id}-node-${count.index + 1}"
    )
  )
}
