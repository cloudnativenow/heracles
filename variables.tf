# Cluster Name
variable "cluster_name" {
  description = "Cluster Name (e.g: hlawork1)"
}

# The AWS Profile to use
variable "profile" {
  description = "AWS Credentials Profile (e.g: hlawork)"
  default = "hlawork"
}

# The AWS Region to use
variable "region" {
  description = "Region to deploy the cluster into (e.g: us-west-2)" 
  default = "us-east-2"
}

# Instance Count
variable "instance_count" {
  description = "Instance count (e.g. 10)"
  default = 3
}

# The public SSH key to use
variable "public_key_path" {
  description = "Public SSH Key to use (e.g: ~/.ssh/heracles.pub)"
  default = "~/.ssh/heracles.pub"
}

# This map defines which AZ to put the 'Public Subnet' in, based on the
# region defined. You will typically not need to change this unless
# you are running in a new region!
variable "subnetaz" {
  type = map
  default = {
    us-east-1 = "us-east-1a"
    us-east-2 = "us-east-2a"
    us-west-1 = "us-west-1a"
    us-west-2 = "us-west-2a"
    eu-west-1 = "eu-west-1a"
    eu-west-2 = "eu-west-2a"
    eu-central-1 = "eu-central-1a"
    ap-southeast-1 = "ap-southeast-1a"
  }
}