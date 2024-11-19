terraform {
  backend "s3" {
    bucket = "saravterraform"          # your S3 bucket name
    key    = "state/terraform.tfstate"        # State file name
    region = "us-east-1"                # Replace with your bucket's region
  }
}
