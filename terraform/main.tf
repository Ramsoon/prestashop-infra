provider "aws" {
  region = "us-east-1"
}

# Security Group
resource "aws_security_group" "prestashop_sg" {
  name = "prestashop_sg"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # restrict to your IP in real case
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # allow EC2 to RDS
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EC2 Instance
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
  
}
resource "aws_instance" "prestashop" {
  ami           = data.aws_ami.ubuntu.id # Get available Ubuntu AMI
  instance_type = "t2.micro"

  security_groups = [aws_security_group.prestashop_sg.name]

  user_data = file("../scripts/user_data.sh")

  tags = {
    Name = "prestashop-server"
  }
}

# RDS MySQL
resource "aws_db_instance" "prestashop_db" {
  allocated_storage    = 20
  engine               = "mysql"
  instance_class       = "db.t3.micro"
  db_name  = "prestashopdb"
  username = var.db_username
  password = var.db_password

  publicly_accessible = true
  skip_final_snapshot = true

  vpc_security_group_ids = [aws_security_group.prestashop_sg.id]
}