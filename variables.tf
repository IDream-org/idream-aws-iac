variable "AWS_REGION" {
  type        = string
  default     = "us-east-1"
  description = "AWS Region"
}

variable "MY_IP" {
  type        = string
  description = "You IP Address"
  sensitive   = true
}

variable "BACKEND_BUCKET_NAME" {
  type        = string
  default     = "idream-backend-iac"
  description = "Bucket name for jenkins backend"
}
