provider "aws" {
  region                  = "us-east-1"
  shared_credentials_file = "~/.aws/credentials"
  profile                 = "default"
}

terraform {
  backend "s3" {
    bucket = "terraform-abhishek"
    key    = "ubuntu/terrafoem.tfstate"
    region = "us-east-1"
  #  dynamodb_table = ""
  }
}

data "http" "myip" {
  url = "http://ipv4.icanhazip.com"
}

resource "aws_security_group" "test" {
  name        = "abhishek-terraform"
  description = "Allow TLS inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    description = "http"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${chomp(data.http.myip.body)}/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "abhishek"
    owner = "abhishek"
    purpose = "bootcamp"

  }
}

resource "aws_lb" "test" {
  name = var.LOAD_BALANCER.NAME
  internal = var.LOAD_BALANCER.INTERNAL
  load_balancer_type = var.LOAD_BALANCER.TYPE
  security_groups = [aws_security_group.test.id]
  subnets = [var.SUBNET_LIST.FIRST, var.SUBNET_LIST.SECOND, var.SUBNET_LIST.THIRD]
   tags = {
        Name = "abhishek-terraform"
        owner = "abhishek"
        purpose = "bootcamp practice"
    }
}

resource "aws_lb_target_group" "test" {
  name        = var.TARGET_GROUP.NAME
  port        = var.TARGET_GROUP.PORT
  protocol    = var.TARGET_GROUP.PROTOCOL
  target_type = var.TARGET_GROUP.TARGET_TYPE
  vpc_id      = var.TARGET_GROUP.VPC_ID
   tags = {
        Name = "abhishek-terraform"
        owner = "abhishek"
        purpose = "bootcamp practice"
    }
}

resource "aws_lb_listener" "test" {
  load_balancer_arn = aws_lb.test.arn
  port              = var.LISTNER.PORT
  protocol          = var.LISTNER.PROTOCOL
  
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.test.arn
  }
  
}

resource "aws_instance" "test" {
    ami           = var.ami
    instance_type = var.instance_type
    vpc_security_group_ids = [aws_security_group.test.id]
    subnet_id = var.subnet_id
    key_name = var.key_name

    tags = {
        Name = "abhishek-terraform"
        owner = "abhishek"
        purpose = "bootcamp practice"
    }
    provisioner "remote-exec" {
        inline = [
        "sudo service nginx start"
        ]
        connection {
        type     = "ssh"
        user     = "ec2-user"
        private_key = file("~/Downloads/abhishek-bootcamp.pem")
        host     = aws_instance.test.public_ip
        }
    }
}

resource "aws_lb_target_group_attachment" "test" {
  target_group_arn = aws_lb_target_group.test.arn
  target_id        = aws_instance.test.id
  port             = 80
}

