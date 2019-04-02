variable "region" {
  description = "AWS region to launch servers."
  default = "us-west-2"
}

variable "private_key_path" {
  description = "Enter the path to the SSH Private Key to run provisioner."
  default = "~/.ssh/Liyuan-IAM-keypair2.pem"
}

#variable "disk_size" {
#  default = 8
#}

variable "count" {
  default = 1
}

variable "group_name" {
  description = "Group name becomes the base of the hostname of the instance"
}

variable "instance_type" {
  description = "AWS region to launch servers."
  default     = "t2.micro"
}

variable "subnet_id" {
  description = "ID of the AWS VPC subnet to use"
}

variable "key_pair_id" {
  description = "ID of the keypair to use for SSH"
  default = "Liyuan-IAM-keypair"
}

variable "security_group_id" {
  description = "ID of the VPC security group to use for network"
}

variable "user_data" {
  description = "Instance user data. Do not pass gzip-compressed data via this argument"
  default     = ""
}