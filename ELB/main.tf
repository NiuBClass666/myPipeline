# Create a new load balancer
resource "aws_elb" "elb" {
  name               = "web-elb"
  subnets            = ["${var.public_subnet_id}"]
  security_groups  = ["${var.security_group_id}"]

  access_logs {
    bucket        = "liyuans-web-elb"
    interval      = 60
  }

  listener {
    instance_port     = 5000
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:5000/"
    interval            = 30
  }

  instances                   = ["${var.instance_ids}"]
  cross_zone_load_balancing   = false
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags = {
    Name = "web-elb"
  }
}

output "dns_name" {
  value = "${aws_elb.elb.dns_name}"
}