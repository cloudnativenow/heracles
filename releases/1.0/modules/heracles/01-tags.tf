# Define our common tags.
locals {
  common_tags = "${map(
    "HeraclesClusterName", "${var.cluster_name}",
    "HeraclesClusterID", "${var.cluster_id}"
  )}"
}