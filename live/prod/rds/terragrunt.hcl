terraform {
  source = "../../../modules/rds"
}
inputs = {
  ENVIRONMENT = "prod"
  MY_IP = "148.74.65.116"
}

include {
  path = find_in_parent_folders()
}