# Save Terraform State to S3 Bucket
terraform {
  backend "s3" {
    bucket = "heracles-terraform-backend"
    key    = "terraform.tfstate"
    region = "us-east-2"
  }
}