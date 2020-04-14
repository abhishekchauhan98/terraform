resource "aws_instance" "create" {
    ami = var.ami
    instance_type = var.instance_type
    vpc_security_group_ids = var.VPC_SG
    subnet_id = var.subnet_id
    key_name = var.key_name 
    user_data = var.user_data
    iam_instance_profile = var.name
    tags = {
        Name = "abhishek-terraform"
        owner = "abhishek"
        purpose = "bootcamp practice"
    }
}

resource "aws_iam_role" "test" {
  name = var.name

  assume_role_policy = <<EOF
    {
    "Version": "2012-10-17",
    "Statement": [
        {
        "Action": "sts:AssumeRole",
        "Principal": {
            "Service": "ec2.amazonaws.com"
        },
        "Effect": "Allow",
        "Sid": ""
        }
    ]
    }
    EOF
}

resource "aws_iam_instance_profile" "test" {
  name = aws_iam_role.test.name
  role = aws_iam_role.test.name
}

resource "aws_iam_policy" "test" {
  name        = "testing"
  description = "A test policy"
  path = "/"
  policy = var.policy
}

resource "aws_iam_role_policy_attachment" "test" {
  role = aws_iam_role.test.name
  policy_arn = aws_iam_policy.test.arn
}