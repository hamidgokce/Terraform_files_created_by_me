
variable "name" {
  description = "name of the project"
  type        = string
}
variable "region" {
  description = "aws region"
}

variable "vpc_cidr_block" {
  description = "vpc cidr block"
}
variable "public_subnet_cidr_blocks" {
  description = "CIDR blocks for subnets"
  type        = map(string)
}
variable "private_subnet_cidr_blocks" {
  description = "CIDR blocks for subnets"
  type        = map(string)
}

variable "availability_zones" {
  description = "availability zone"
  type        = list(string)
}
variable "security_group_name" {
  description = "security group name"
}
variable "ingress_ports" {
  description = "Ingress ports for security group"
  type = list(object({
    port        = number
    description = string
  }))
}

variable "ingress_ports_nexp" {
  description = "Ingress ports for security group"
  type = list(object({
    port        = number
    description = string
  }))
}

variable "egress_ports" {
  description = "Egress ports for security group"
  type = list(object({
    port        = number
    description = string
  }))
}
variable "ami_owners" {
  description = "ami owners"
}
variable "ami_name" {
  description = "ami name"
}
variable "ami_virtualization-type" {
  description = "ami virtualization type"
}
variable "instance_type" {
  description = "instance type"
}
variable "key_name" {
  description = "key name"
}
variable "user_data_file_ps" {
  description = "user data file for prometheus server"

}
variable "user_data_file_nexp" {
  description = "user data file for node exporter"

}

variable "Hamid-dynamic-ports" {
  default = [80, 443]
  #definition = "Dynamic ports of security groups"
}