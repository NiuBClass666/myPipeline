variable "instance_ids" {
  type 		  = "list"
  description = "web instance ids"
}

variable "public_subnet_id" {
  description = "web instance ids"
}

variable "security_group_id" {
  description = "ID of the VPC security group to use for network"
}

variable "elb_prefix" {}

variable "name" {}