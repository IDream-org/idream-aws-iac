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
}