variable "region" {
  description = "The region to deploy the cluster in, e.g: us-east-1"
}

variable "instance_count" {
  description = "Instance count (e.g. 10)"
}

variable "amisize" {
  description = "Cluster node size, e.g: t2.large"
}

variable "volumesize" {
  description = "Root volume size of the cluster (Gigs), e.g: 50"
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC, e.g: 10.0.0.0/16"
}

variable "subnetaz" {
  description = "The AZ for the public subnet, e.g: us-east-1a"
  type        = map
}

variable "subnet_cidr" {
  description = "The CIDR block for the public subnet, e.g: 10.0.1.0/24"
}

variable "key_name" {
  description = "The name of the key to user for ssh access, e.g: heracles"
}

variable "public_key_path" {
  description = "The local public key path, e.g. ~/.ssh/id_rsa.pub"
}

variable "cluster_name" {
  description = "Name of the cluster, e.g: 'hlawork1'. Useful when running multiple clusters in the same AWS account."
}

variable "cluster_id" {
  description = "ID of the cluster, e.g: 'hlawork1-us-east-1'. Useful when running multiple clusters in the same AWS account."
}

data "aws_availability_zones" "azs" {}
