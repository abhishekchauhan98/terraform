provider "aws" {
  region                  = "us-east-1"
  shared_credentials_file = "~/.aws/credentials"
  profile                 = "ttn-newers"
}


# module "creating_iam_role" {
#   source = "./modules/iam"
#   iam_instance_profile = "EC2-S3-FullAccess-Role"
# }

module "create_instance" {
  source = "./modules/ec2"
  user_data = file("nginx.sh")
  policy = file("ec2policy.json")
}

