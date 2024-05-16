module "ec2" {
  source      = "../../modules/ec2"
  ENVIRONMENT = var.ENVIRONMENT
  MY_IP       = var.MY_IP
}

# module "rds" {
#   source = "../../modules/rds"
#     ENVIRONMENT = var.ENVIRONMENT
#   MY_IP  = var.MY_IP
# }