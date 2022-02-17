# Save Terraform State to S3 Bucket
terraform {
  backend "s3" {
    bucket = "junk-terraform-backend"    
    key    = "terraform.tfstate"
    region = "us-east-2"
  }
}
