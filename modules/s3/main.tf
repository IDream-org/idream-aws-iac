resource "aws_s3_bucket" "idream-s3-api-artifacts" {
  bucket = "idream-s3-api-artifacts-${var.ENVIRONMENT}"

  tags = {
    Name    = "idream-s3-api-artifacts-${var.ENVIRONMENT}"
    Project = "IDream-${var.ENVIRONMENT}"
  }
}