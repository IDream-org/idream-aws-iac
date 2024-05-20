# S3 bucket for Elastic Beanstalk
resource "aws_s3_bucket" "beanstalk_bucket" {
  bucket = "my-beanstalk-bucket" # change to a unique bucket name
  acl    = "private"
  
  tags = {
    Name = "beanstalk-bucket"
  }
}

# Upload default HTML file to S3 bucket
resource "aws_s3_bucket_object" "default_html" {
  bucket = aws_s3_bucket.beanstalk_bucket.bucket
  key    = "index.html"
  source = "index.html"
  acl    = "public-read" # change as needed for your security requirements

  tags = {
    Name = "DefaultHTML"
  }
}

# SQS Queue
resource "aws_sqs_queue" "beanstalk_queue" {
  name = "beanstalk-queue"
}

# IAM role and policy for Elastic Beanstalk
resource "aws_iam_role" "beanstalk_role" {
  name = "beanstalk-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "elasticbeanstalk.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy" "beanstalk_policy" {
  name = "beanstalk-policy"
  role = aws_iam_role.beanstalk_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:*",
          "sqs:*",
          "ec2:*",
          "elasticloadbalancing:*",
          "autoscaling:*",
          "cloudwatch:*",
          "logs:*",
          "cloudformation:*"
        ]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}

# Elastic Beanstalk Application
resource "aws_elastic_beanstalk_application" "beanstalk_app" {
  name        = "my-app"
  description = "My Elastic Beanstalk Application"
}

# Elastic Beanstalk Environment
resource "aws_elastic_beanstalk_environment" "beanstalk_env" {
  name                = "my-app-env"
  application         = aws_elastic_beanstalk_application.beanstalk_app.name
  solution_stack_name = "64bit Amazon Linux 2023 v6.1.5 running Node.js 20" # change as per your application's stack

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "QUEUE_NAME"
    value     = aws_sqs_queue.beanstalk_queue.name
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "BUCKET_NAME"
    value     = aws_s3_bucket.beanstalk_bucket.bucket
  }

  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "EnvironmentType"
    value     = "LoadBalanced"
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     = aws_iam_role.beanstalk_role.name
  }
}

# Output the S3 bucket name
output "s3_bucket_name" {
  value = aws_s3_bucket.beanstalk_bucket.bucket
}

# Output the SQS queue URL
output "sqs_queue_url" {
  value = aws_sqs_queue.beanstalk_queue.url
}
