variable "ami" {
  default = "ami-07ebfd5b3428b6f4d"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "subnet_id" {
  default = "subnet-09b7472be47ade27d"
}

variable "key_name" {
  default = "abhishek-bootcamp"
}

variable "user_data" {
  type = string
  default = null
}

variable "iam_instance_profile" {
  type = string
  default = ""
}

variable "VPC_SG" {
  default = ["sg-03743288f9ec6e322"]
}

variable "name" {
  default = "testing"
}

variable "policy" {
  type = string
  default = ""
}
