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
  policy = file("${vars.policy}")
}

resource "aws_iam_role_policy_attachment" "test" {
  name = "TEST"
  role = aws_iam_role.test.name
  policy_arn = aws_iam_policy.test.arn
}