module "rds" {
  source = "../../../modules/rds"
  ENVIRONMENT = var.ENVIRONMENT
  MY_IP  = var.MY_IP
}

module "s3" {
  source = "../../../modules/s3"
  ENVIRONMENT = var.ENVIRONMENT
}


module "beanstalk" {
  source = "../../../modules/beanstalk"
  ENVIRONMENT = var.ENVIRONMENT
}