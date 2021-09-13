# Create the Heracles Cluster using our module
module "heracles" {
  source          = "./modules/heracles"
  region          = "${var.region}"
  instance_count  = "${var.instance_count}"
  amisize         = "t2.large"
  volumesize      = "50"
  vpc_cidr        = "15.0.0.0/16"
  subnetaz        = "${var.subnetaz}"
  subnet_cidr     = "15.0.1.0/24"
  key_name        = "${var.cluster_name}-${var.region}"
  public_key_path = "${var.public_key_path}"
  cluster_name    = "${var.cluster_name}"
  cluster_id      = "${var.cluster_name}-${var.region}"
}

# Output some useful variables for quick SSH access etc.
output "control-public_ip" {
  value = module.heracles.control-public_ip
}

output "nginx-public_ip" {
  value = module.heracles.nginx-public_ip
}

output "spring-public_ip" {
  value = module.heracles.spring-public_ip
}

output "mysql-public_ip" {
  value = module.heracles.mysql-public_ip
}

# Output some useful variables for Ansible
output "control-private_ip" {
  value = module.heracles.control-private_ip
}

output "nginx-private_ip" {
  value = module.heracles.nginx-private_ip
}

output "spring-private_ip" {
  value = module.heracles.spring-private_ip
}

output "mysql-private_ip" {
  value = module.heracles.mysql-private_ip
}