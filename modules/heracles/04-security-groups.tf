# This security group allows intra-node communication on all ports with all
# protocols.
resource "aws_security_group" "heracles-vpc" {
  name        = "heracles-vpc"
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
      "Name", "Heracles Internal VPC"
    )
  )
}

# This security group allows public ingress to the instances for HTTP, HTTPS
# and common HTTP/S proxy ports.
resource "aws_security_group" "heracles-public-ingress" {
  name        = "heracles-public-ingress"
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
      "Name", "Heracles Public Ingress"
    )
  )
}

# This security group allows public egress from the instances for HTTP and
# HTTPS, which is needed for yum updates, git access etc etc.
resource "aws_security_group" "heracles-public-egress" {
  name        = "heracles-public-egress"
  description = "Security group that allows egress to the internet for instances over HTTP and HTTPS."
  vpc_id      = aws_vpc.heracles.id

  # HTTP
  egress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTPS
  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Use our common tags and add a specific name.
  tags = merge(
    local.common_tags,
    map(
      "Name", "Heracles Public Egress"
    )
  )
}

# Security group which allows SSH access to a host. Used for the bastion.
resource "aws_security_group" "heracles-ssh" {
  name        = "heracles-ssh"
  description = "Security group that allows public ingress over SSH."
  vpc_id      = aws_vpc.heracles.id

  # SSH
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Use our common tags and add a specific name.
  tags = merge(
    local.common_tags,
    map(
      "Name", "Heracles SSH Access"
    )
  )
}