data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

resource "aws_iam_role" "idream-beanstalk-role" {
  name = "idream-beanstalk-role-${var.ENVIRONMENT}"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "elasticbeanstalk.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })

  managed_policy_arns = [
    "arn:aws:iam::aws:policy/AWSElasticBeanstalkManagedUpdatesCustomerRolePolicy",
    "arn:aws:iam::aws:policy/service-role/AWSElasticBeanstalkEnhancedHealth"
  ]
}

resource "aws_iam_instance_profile" "idream-beanstalk-instance-profile" {
  name = "idream-beanstalk-instance-profile-${var.ENVIRONMENT}"
  role = aws_iam_role.idream-beanstalk-role.name
}

resource "aws_elastic_beanstalk_application" "idream-beanstalk" {
  name = "idream-beanstalk-${var.ENVIRONMENT}"
  description = "Elastic Beanstalk Application for IDream ${var.ENVIRONMENT}"

  tags = {
    Name    = "idream-beanstalk-${var.ENVIRONMENT}"
    Project = "IDream-${var.ENVIRONMENT}"
  }
}

resource "aws_elastic_beanstalk_environment" "idream-beanstalk-nodejs-env" {
  name                = "idream-beanstalk-nodejs-env-${var.ENVIRONMENT}"
  application         = aws_elastic_beanstalk_application.idream-beanstalk.name
  solution_stack_name = "64bit Amazon Linux 2023 v6.1.5 running Node.js 20"

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     = aws_iam_instance_profile.idream-beanstalk-instance-profile.name
  }

  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "EnvironmentType"
    value     = "LoadBalanced" 
  }

  setting {
    namespace = "aws:autoscaling:asg"
    name      = "MinSize"
    value     = "1"
  }

  setting {
    namespace = "aws:autoscaling:asg"
    name      = "MaxSize"
    value     = "1"
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "VPCId"
    value     = data.aws_vpc.default.id
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "Subnets"
    value     = join(",", data.aws_subnets.default.ids)
  }
}