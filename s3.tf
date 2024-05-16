module "s3_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket = "idream-backend-s3"
  acl    = "private"

  control_object_ownership = true
  object_ownership         = "ObjectWriter"

  tags = {
    Name    = "idream-backend-s3"
    Project = "IDream"
  }
}
