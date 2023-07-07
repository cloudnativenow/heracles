# Define an Amazon Linux AMI.
data "aws_ami" "amazonlinux" {
  most_recent = true
  owners = ["565710867928"]

  filter {
    name   = "name"
    values = ["ServiceNow_AmazonLinux2_Image_*"]
  }
}
