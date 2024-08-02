provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "my_sg" {
  name        = "allow-ssh"
  description = "security group that allows ssh and all egress traffic"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "webserver-sg"
  }
}

resource "aws_instance" "my_ec2_instance" {
  ami                    = "ami-06223525b1b3eec17" # notre propre image machine
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.my_sg.id]
}

output "instance_ip" {
  value = aws_instance.my_ec2_instance.public_ip
}