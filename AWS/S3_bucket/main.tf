# Configure the AWS provider
provider "aws" {
  region = "us-east-1"
}

# Create an S3 bucket
resource "aws_s3_bucket" "terraform_state" {
  bucket = var.bucket_name

  versioning {
    enabled = true
  }

  lifecycle {
    prevent_destroy = true
  }
}
