# Save Terraform State to S3 Bucket
terraform {
  backend "s3" {
    # bucket = "hlawork1-terraform-backend"
    # bucket = "hlawork2-terraform-backend"
    # bucket = "hlawork3-terraform-backend"
    # bucket = "hlawork4-terraform-backend"
    # bucket = "hlawork5-terraform-backend"
    bucket = "hlawork99-terraform-backend"    
    key    = "terraform.tfstate"
    region = "us-east-2"
  }
}