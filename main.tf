module "ec2_instance" {
  source = "./modules/jenkins"
  MY_IP  = var.MY_IP
}