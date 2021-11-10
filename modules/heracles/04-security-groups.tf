# This security group allows intra-server communication on all ports with all
# protocols.
resource "aws_security_group" "heracles-vpc" {
  name        = "${var.cluster_id}-sg"
  description = "Default security group that allows all instances in the VPC to talk to each other over any port and protocol."
  vpc_id      = aws_vpc.heracles.id

  ingress {
    from_port = "0"
    to_port   = "0"
    protocol  = "-1"
    self      = true
  }

  egress {
    from_port = "0"
    to_port   = "0"
    protocol  = "-1"
    self      = true
  }

  # Use our common tags and add a specific name.
  tags = merge(
    local.common_tags,
    map(
      "Name", "${var.cluster_id}-sg"
    )
  )
}

# This security group allows public ingress to the instances for HTTP, HTTPS
# and common HTTP/S proxy ports.
resource "aws_security_group" "heracles-public-ingress" {
  name        = "${var.cluster_id}-ingress"
  description = "Security group that allows public ingress to instances, HTTP, HTTPS and more."
  vpc_id      = aws_vpc.heracles.id

  # HTTP
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTP Proxy 1
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTPS
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTPS Proxy
  ingress {
    from_port   = 8443
    to_port     = 8443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

    # Use our common tags and add a specific name.
  tags = merge(
    local.common_tags,
    map(
      "Name", "${var.cluster_id}-ingress"
    )
  )
}

# This security group allows public egress from the instances for HTTP and
# HTTPS, which is needed for yum updates, git access etc etc.
resource "aws_security_group" "heracles-public-egress" {
  name        = "${var.cluster_id}-egress"
  description = "Security group that allows egress to the internet for instances over HTTP and HTTPS."
  vpc_id      = aws_vpc.heracles.id

  # All Traffic
  egress {
    from_port = "0"
    to_port   = "0"
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Use our common tags and add a specific name.
  tags = merge(
    local.common_tags,
    map(
      "Name", "${var.cluster_id}-egress"
    )
  )
}

# Security group which allows SSH access to a host. Used for the bastion.
resource "aws_security_group" "heracles-ssh" {
  name        = "${var.cluster_id}-ssh"
  description = "Security group that allows public ingress over SSH."
  vpc_id      = aws_vpc.heracles.id

  # SSH
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["165.225.0.0/17","137.83.128.0/18","165.225.192.0/18","104.129.192.0/20","185.46.212.0/22","199.168.148.0/22","209.51.184.0/26","213.152.228.0/24","216.218.133.192/26","216.52.207.64/26","27.251.211.238/32","64.74.126.64/26","70.39.159.0/24","72.52.96.0/26","8.25.203.0/24","89.167.131.0/24","136.226.0.0/16","147.161.128.0/17"]
  }

  # Use our common tags and add a specific name.
  tags = merge(
    local.common_tags,
    map(
      "Name", "${var.cluster_id}-ssh"
    )
  )
}