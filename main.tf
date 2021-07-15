# Create the Heracles cluster using our module.
module "heracles" {
  source          = "./modules/heracles"
  region          = "${var.region}"
  amisize         = "t2.large"    //  Smallest that meets the min specs for OS
  vpc_cidr        = "10.0.0.0/16"
  subnetaz        = "${var.subnetaz}"
  subnet_cidr     = "10.0.1.0/24"
  key_name        = "heracles"
  public_key_path = "${var.public_key_path}"
  cluster_name    = "heracles-cluster"
  cluster_id      = "heracles-cluster-${var.region}"
}