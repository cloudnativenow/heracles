# Define our common tags.
locals {
  common_tags = "${tomap({
    "HeraclesClusterName"= "${var.cluster_name}",
    "HeraclesClusterID"= "${var.cluster_id}"
  })}"
}
