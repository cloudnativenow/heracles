# Define our common tags.
locals {
  common_tags = "${map(
    "HeraclesCluster", "${var.cluster_name}",
    "HeraclesClusterID", "${var.cluster_id}"
  )}"
}