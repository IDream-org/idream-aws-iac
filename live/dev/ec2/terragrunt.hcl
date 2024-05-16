terraform {
  source = "../../../modules/ec2"
}
inputs = {
  ENVIRONMENT = "dev"
  MY_IP = "148.74.65.116"
}

include {
  path = find_in_parent_folders()
}