terraform {
  backend "s3" {
    bucket = "idream-backend-s3"
    key    = "terraform/backend"
    region = "us-east-1"
  }
}