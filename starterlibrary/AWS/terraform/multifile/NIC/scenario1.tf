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

provider "aws" {
  version = "~> 2.0"
  region  = "${var.aws_region}"
}

resource "aws_vpc" "default" {
  cidr_block = "10.0.0.0/24"
}

resource "aws_subnet" "default" {
  vpc_id                  = "${aws_vpc.default.id}"
  cidr_block              = "10.0.0.0/24"
  map_public_ip_on_launch = true
}

module "public_ssh_key" {
  source         = "./ssh"
  key_name       = "Orpheus Public Key"
  public_ssh_key = "${var.public_ssh_key}"
}

resource "aws_instance" "webserver01" {
  ami = "${var.webserver01_ami}"
  key_name = "${aws_key_pair.auth.id}"
  instance_type = "${var.webserver01_aws_instance_type}"
  availability_zone = "${var.availability_zone}"
  vpc_security_group_ids = ["${var.security_group_id}"]
  subnet_id  = "${aws_subnet.default.id}"
  connection {
    type = "ssh"
    user = "${var.webserver01_connection_user}"
    private_key = "${var.webserver01_connection_private_key}"
  }
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

resource "aws_ebs_volume" "volume_webserver01" {
    availability_zone = "${var.availability_zone}"
    size              = "${var.volume_webserver01_volume_size}"
}

resource "aws_volume_attachment" "webserver01_volume_webserver01_volume_attachment" {
  device_name = "/dev/sdh"
  volume_id   = "${aws_ebs_volume.volume_webserver01.id}"
  instance_id = "${aws_instance.webserver01.id}"
}

resource "aws_alb" "app_balancer" {
  name            = "app_balancer-alb"
  internal        = false
  enable_deletion_protection = true
  subnets         = ["${aws_subnet.default.*.id}"]
  access_logs {
    bucket        = "foo"
    bucket_prefix = "bar"
    interval      = 60
  }
  tags {
    Environment = "production"
  }
}

