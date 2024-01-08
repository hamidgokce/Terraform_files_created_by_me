//variable "aws_secret_key" {}
//variable "aws_access_key" {}
variable "region" {
  default = "us-east-2"
}
variable "mykey" {
  default = "Aws_key_east2"
}
variable "tags" {
  default = "microsevice-rancher-server"
}
variable "myami" {
  description = "ubuntu 20.04 ami"
  default     = "ami-07b36ea9852e986ad"
}
variable "instancetype" {
  default = "t3a.medium"
}

variable "secgrname" {
  default = "rancher-server-sec-gr"
}

variable "domain-name" {
  default = "*.hamidgokce.com"
}

variable "rancher-subnet" {
  default = "subnet-00c6ee1b81c18fdfe"
}

variable "hostedzone" {
  default = "hamidgokce.com"
}