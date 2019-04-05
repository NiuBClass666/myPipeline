variable "access_key" {
	default = ""

}
variable "secret_key" {
	default = ""

}
variable "region" {
  description = "AWS region to launch servers."
  default = "us-west-2"
}

variable "key_pair_id" {
  description = "ID of the keypair to use for SSH"
  default = "Liyuan-IAM-keypair"
}

variable "private_key_path" {
  description = "Enter the path to the SSH Private Key to run provisioner."
  default = "~/.ssh/Liyuan-IAM-keypair2.pem"
}
