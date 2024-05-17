variable "ENVIRONMENT" {
  type        = string
  default     = "dev"
  description = "Product Environment"
}

variable "AWS_REGION" {
  type        = string
  default     = "us-east-1"
  description = "AWS Region"
}

variable "MY_IP" {
  type        = string
  description = "You IP Address"
  default     = "148.74.65.116"
  sensitive   = true
}