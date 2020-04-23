variable "AWS_REGION" {
  default = "us-east-1"
}

#variable "PATH_TO_PRIVATE_KEY" {
#  default = "mykey"
#}

#variable "PATH_TO_PUBLIC_KEY" {
  #default = "mykey.pub"
#}

variable "AMIS" {
  type = map(string)
  default = {
    us-east-1 = "ami-0e2ff28bfb72a4e45"
    us-west-2 = "ami-06b94666"
    eu-west-1 = "ami-844e0bf7"
  }
}

variable "INSTANCE_DEVICE_NAME" {
  default = "/dev/xvdh"
}

