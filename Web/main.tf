resource"aws_instance""Web"{
  count = "${var.count}"

  instance_type          = "${var.instance_type}"
  ami                    = "${data.aws_ami.ubuntu.id}"
  key_name               = "${var.key_pair_id}"
  vpc_security_group_ids = ["${var.security_group_id}"]
  subnet_id              = "${var.subnet_id}"
  user_data              = "${file("./Web/local-exec.sh")}"
  
  #root_block_device {
  #    volume_size = "${var.disk_size}"
  #}
  
  tags {
      Name = "${format("%s%02d", var.group_name, count.index + 1)}" # -> "backend02"
      Group = "${var.group_name}"
  }
  
  lifecycle {
    create_before_destroy = false
  }
  
  # Provisioning
  
  #connection {
  #  user = "ubuntu"
  #  private_key = "${file(var.private_key_path)}"
  #}

  #provisioner "remote-exec" {
  #  inline = [
  #    "sudo apt-get update",
  #    "sudo apt install apt-transport-https ca-certificates curl software-properties-common -y",
  #    "curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -",
  #    "sudo add-apt-repository \"deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable #edge\" ",
  #    "sudo apt-get update ",
  #    "sudo apt-get install -y docker-ce",
  #
  #    "sudo docker run -d   --name web --rm -p 8000:8000 liyuansdockerhub/insight_project",
  #    "sudo docker run -d   --name watchtower   -v /var/run/docker.sock:/var/run/docker.sock  v2tec/watchtower -i 30",
  #    
  #  ]
  #}
}

data "aws_ami" "ubuntu" {
    most_recent = true
filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
}

filter {
    name   = "virtualization-type"
    values = ["hvm"]
}

owners = ["099720109477"] # Canonical
}

# Used for configuring ELBs.
output "instance_ids" {
    value = ["${aws_instance.Web.*.id}"]
}