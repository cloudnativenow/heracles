# Create the Heracles Cluster using our module
module "heracles" {
  source          = "./modules/heracles"
  region          = "${var.region}"
  amisize         = "t2.small"    //  Smallest that meets the min specs for OS
  vpc_cidr        = "15.0.0.0/16"
  subnetaz        = "${var.subnetaz}"
  subnet_cidr     = "15.0.1.0/24"
  key_name        = "heracles"
  public_key_path = "${var.public_key_path}"
  cluster_name    = "heracles-cluster"
  cluster_id      = "heracles-cluster-${var.region}"
}

# Output some useful variables for quick SSH access etc.
output "bastion-public_ip" {
  value = module.heracles.bastion-public_ip
}

output "node-public_ip" {
  value = module.heracles.node-public_ip
}