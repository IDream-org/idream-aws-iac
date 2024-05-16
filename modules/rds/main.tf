module "db" {
  source = "terraform-aws-modules/rds/aws"

  identifier = "idream-rds"

  engine            = "postgres"
  engine_version    = "16.1"
  instance_class    = "db.t3.micro"
  allocated_storage = 5

  db_name  = "idreamrds"
  username = "postgres"
  port     = "5432"

  iam_database_authentication_enabled = true

  family = "postgres16"

  vpc_security_group_ids = [aws_security_group.idream-rds-sg.id]
}

resource "aws_security_group" "idream-rds-sg" {
  name        = "idream-rds-sg"
  description = "Security group for IDream RDS instance"

  ingress {
    description = "Allow my ip to connect though port 5432"
    from_port   = "5432"
    to_port     = "5432"
    protocol    = "tcp"
    cidr_blocks = ["${var.MY_IP}/32"]
  }

  ingress {
    description = "Allow SSH from my computer"
    from_port   = "22"
    to_port     = "22"
    protocol    = "tcp"
    cidr_blocks = ["${var.MY_IP}/32"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "idream-rds-sg"
    Project = "IDream"
  }
}