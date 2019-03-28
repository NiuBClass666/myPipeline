variable "access_key" {
	default = "AKIAIQXXFEH3KSRE64RA"
}
variable "secret_key" {
	default = "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"
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