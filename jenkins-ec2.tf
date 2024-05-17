resource "aws_instance" "idream-jenkins-instance" {
  ami                    = "ami-0e001c9271cf7f3b9"
  instance_type          = "t2.small"
  availability_zone      = "us-east-1a"
  vpc_security_group_ids = [aws_security_group.idream-jenkins-instance-sg.id]
  key_name               = aws_key_pair.idream-jenkins-instance-kp.key_name
  user_data              = file("${path.module}/install_jenkins.sh")

  tags = {
    Name    = "idream-jenkins-instance"
    Project = "IDream"
  }
}

resource "aws_key_pair" "idream-jenkins-instance-kp" {
  key_name   = "idream-jenkins-instance-kp"
  public_key = file("${path.module}/aws_kp.pub")
}

resource "aws_eip" "idream-jenkins-instance-eip" {
  instance = aws_instance.idream-jenkins-instance.id

  tags = {
    Name    = "idream-jenkins-instance-eip"
    Project = "IDream"
  }
}

resource "aws_security_group" "idream-jenkins-instance-sg" {
  name        = "idream-jenkins-instance-sg"
  description = "Security group for IDream jenkins instance"

  ingress {
    description = "Allow all traffic through port 8080"
    from_port   = "8080"
    to_port     = "8080"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
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
    Name    = "idream-jenkins-instance-sg"
    Project = "IDream"
  }
}