variable "ami" {
  default = "ami-0904b7dea25c46c62"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "vpc_id" {
  default = "vpc-0faa7c85885ac9ab2"
}

variable "subnet_id" {
  default = "subnet-09b7472be47ade27d"
}

variable "key_name" {
  default = "abhishek-bootcamp"
}

variable "LOAD_BALANCER" {
  type = map
  default = {
      NAME = "terraform-abhishek"
      INTERNAL = "false"
      TYPE = "application"
  }
}

variable "SUBNET_LIST" {
  type = map
  default = {
      FIRST = "subnet-09b7472be47ade27d"
      SECOND = "subnet-02781885e8b26ae1f"
      THIRD = "subnet-048b57f5eab63d93f"
  }
}

variable "TARGET_GROUP" {
  type = map
  default = {
      NAME = "Terraform-abhishek"
      PORT = 80
      PROTOCOL = "HTTP"
      TARGET_TYPE = "instance"
      VPC_ID = "vpc-0faa7c85885ac9ab2"
  }
}

variable "LISTNER" {
  type = map
  default = {
      PORT = "80"
      PROTOCOL = "HTTP"    
    }
}

