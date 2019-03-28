resource"aws_instance""jenkins"{
  count = "${var.count}"

  instance_type          = "${var.instance_type}"
  ami                    = "${data.aws_ami.ubuntu.id}"
  key_name               = "${var.key_pair_id}"
  vpc_security_group_ids = ["${var.security_group_id}"]
  subnet_id              = "${var.subnet_id}"

  #root_block_device {
  #    volume_size = "${var.disk_size}"
  #}
  
  tags {
      Name = "${format("%s%02d", var.group_name, count.index + 1)}" # -> "backend02"
      Group = "${var.group_name}"
  }
  
  lifecycle {
    create_before_destroy = true
  }
  
  # Provisioning
  
  connection {
    user = "ubuntu"
    private_key = "${file(var.private_key_path)}"
  }

  #provisioner "local-exec" {
  #    command = "scp -i ~/.ssh/Liyuan-IAM-keypair2.pem jenkins-cli.jar ubuntu@${aws_instance.example.public_ip}:./"
  #    command = "scp -i ~/.ssh/Liyuan-IAM-keypair2.pem template.xml ubuntu@${aws_instance.example.public_ip}:./"
      

  #}


  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "wget --no-check-certificate -qO - https://pkg.jenkins.io/debian/jenkins-ci.org.key | sudo apt-key add - ",
      "echo deb https://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list ",
      "sudo apt-get install -y python-software-properties debconf-utils",
      "sudo add-apt-repository ppa:webupd8team/java --yes",
      "sudo apt-get update",
      "echo \"oracle-java8-installer shared/accepted-oracle-license-v1-1 select true\" | sudo debconf-set-selections",
      "echo debconf shared/accepted-oracle-license-v1-1 seen true | sudo debconf-set-selections",
      "echo \"CONFIG DONE\" ",
      "sudo apt-get install oracle-java8-installer -y",

      "sudo apt-get update",
      "sudo apt install apt-transport-https ca-certificates curl software-properties-common -y",
      "curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -",
      "sudo add-apt-repository \"deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable edge\" ",
      "sudo apt-get update ",
      "sudo apt-get install -y docker-ce",

      "sudo apt-get update ",
      "env JAVA_OPTS= \" -Djenkins.install.runSetupWizard=false \" ",
      "sudo apt-get install jenkins -y",

      

      "sudo gpasswd -a jenkins docker",       
      "sudo service docker restart",  
      
      #"sudo shutdown -r now",
      
      #"sudo sleep 10",

      #"java -jar jenkins-cli.jar -s http://localhost:8080/ create-job autoBuild < template.xml",

    ]
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