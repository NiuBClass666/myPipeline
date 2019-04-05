resource"aws_instance""jenkins"{
  count = "${var.count}"

  instance_type          = "${var.instance_type}"
  ami                    = "${data.aws_ami.ubuntu.id}"
  key_name               = "${var.key_pair_id}"
  vpc_security_group_ids = ["${var.security_group_id}"]
  subnet_id              = "${var.subnet_id}"
  user_data              = "${file("./Jenkins/local-exec.sh")}"

  tags {
      Name = "${format("%s%02d", var.group_name, count.index + 1)}" # -> "backend02"
      Group = "${var.group_name}"
  }
  
  lifecycle {
    create_before_destroy = true
  }

  provisioner "file" {
    source      = "configs/"
    destination = "/tmp"

    connection {
        type     = "ssh"
        user     = "ubuntu"       
        private_key = "${file("${var.private_key_path}")}"
        agent = false
    } 
  }
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
    value = ["${aws_instance.jenkins.*.id}"]
}