module "ec2_instance" {
  source     = "./modules/jenkins"
  MY_IP      = var.MY_IP
  AWS_REGION = var.AWS_REGION
}

module "db" {
  source = "./modules/rds"
  MY_IP  = var.MY_IP
}