#################################################################
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Licensed Materials - Property of IBM
#
# ©Copyright IBM Corp. 2017.
#
#################################################################

## REFERENCE {"aws_network":{"type": "aws_reference_network"}}

provider "aws" {
  version = "~> 2.0"
  region  = "${var.aws_region}"
}

#resource "aws_key_pair" "orpheus_public_key" {
#  key_name   = "${var.public_ssh_key_name}"
#  public_key = "${var.public_ssh_key}"
#}

resource "aws_instance" "webserver" {
  ami           = "${var.webserver_ami}"
#  key_name      = "${aws_key_pair.orpheus_public_key.id}"
  key_name      = "${var.public_ssh_key_name}"
  instance_type = "${var.webserver_aws_instance_type}"
  availability_zone = "${var.availability_zone}"
  subnet_id  = "${var.subnet_id}"
  vpc_security_group_ids = ["${var.security_group_id}"]
  tags {
    Name = "${var.webserver_name}"
  }
}

resource "aws_alb" "alb" {
  name                       = "app-balancer-alb"
  internal                   = false
  load_balancer_type         = "application"
  enable_deletion_protection = false
  subnets                    = ["subnet-0fcc80915848c7e1f","subnet-0ad19fbd59cd5b0a4"]
  security_groups            = ["${var.security_group_id}"]
#  access_logs {
#    bucket  = "mcm-test-s3"
#    prefix  = "app-balancer"
#    enabled = true
#  }
  tags {
    Environment = "production"
  }
}

resource "aws_alb_target_group" "alb" {
  name     = "app-balancer-alb-target"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "${var.vpc_id}"

  health_check {
    interval            = 30
    path                = "/index.html"
    port                = 80
    protocol            = "HTTP"
    timeout             = 5
    unhealthy_threshold = 2
    matcher             = 200
  }
}

resource "aws_alb_target_group_attachment" "alb" {
  target_group_arn = aws_alb_target_group.alb.arn
  target_id        = aws_instance.webserver.id
  port             = 80
}

resource "aws_alb_listener" "alb" {
  load_balancer_arn = "${aws_alb.alb.arn}"
  port              = "80"
  protocol          = "HTTP"
#  ssl_policy        = "ELBSecurityPolicy-2016-08"
#  certificate_arn   = "${aws_lb_listener_certificate.alb.arn}"
  default_action {
    type            = "forward"
    target_group_arn = "aws_alb_target_group.alb.arn"
  }
}

#resource "aws_lb_listener_certificate" "alb" {
#  listener_arn    = aws_lb_listener.front_end.arn
#  certificate_arn = aws_acm_certificate.example.arn
#}

resource "aws_ebs_volume" "volume_webserver" {
    availability_zone = "${var.availability_zone}"
    size              = "${var.volume_webserver_volume_size}"
}

resource "aws_volume_attachment" "webserver_volume_webserver_volume_attachment" {
  device_name = "/dev/sdh"
  volume_id   = "${aws_ebs_volume.volume_webserver.id}"
  instance_id = "${aws_instance.webserver.id}"
}



