# Save Terraform State to S3 Bucket
terraform {
  backend "s3" {
    # bucket = "hlawork99-terraform-backend"
    # bucket = "hlawork1-terraform-backend"
    bucket = "hlawork2-terraform-backend"
    key    = "terraform.tfstate"
    region = "us-east-2"
  }
}