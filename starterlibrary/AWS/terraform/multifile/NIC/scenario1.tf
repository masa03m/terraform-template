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

resource "aws_instance" "webserver01" {
  ami = "${var.webserver01_ami}"
  key_name = "${aws_key_pair.auth.id}"
  instance_type = "${var.webserver01_aws_instance_type}"
  availability_zone = "${var.availability_zone}"
  subnet_id  = "${var.subnet_id}"
  vpc_security_group_ids = ["${var.security_group_id}"]
  tags {
    Name = "${var.webserver01_name}"
  }
}

resource "tls_private_key" "ssh" {
    algorithm = "RSA"
}

resource "aws_key_pair" "auth" {
    key_name = "${var.aws_key_pair_name}"
    public_key = "${tls_private_key.ssh.public_key_openssh}"
}

resource "aws_alb" "app-balancer" {
  name                       = "app-balancer-alb"
  internal                   = false
  load_balancer_type         = "application"
  enable_deletion_protection = false
  subnets                    = ["subnet-0fcc80915848c7e1f","subnet-0ad19fbd59cd5b0a4"]
  security_groups            = ["${var.security_group_id}"]
  access_logs {
    bucket  = "mcm-test-s3"
    prefix  = "app-balancer"
    enabled = true
  }
  tags {
    Environment = "production"
  }
}

resource "aws_ebs_volume" "volume_webserver1" {
    availability_zone = "${var.availability_zone}"
    size              = "${var.volume_webserver1_volume_size}"
}

resource "aws_volume_attachment" "webserver01_volume_webserver1_volume_attachment" {
  device_name = "/dev/sdh"
  volume_id   = "${aws_ebs_volume.volume_webserver1.id}"
  instance_id = "${aws_instance.webserver01.id}"
}
