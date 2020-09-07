variable "aws_region" {
  description = "AWS region to launch servers."
  default     = "ap-northeast-1"
}

variable "webserver_ami" {
  type = "string"
  default    = "ami-01c36f3329957b16a"
  description = "生成済み"
}

variable "webserver_aws_instance_type" {
  type = "string"
  default = "t2.small"
  description = "生成済み"
}

variable "availability_zone" {
  type = "string"
  default     = "ap-northeast-1a"
  description = "生成済み"
}

variable "webserver_name" {
  type = "string"
  default     = "webserver01"
  description = "生成済み"
}

variable "security_group_id" {
  type = "string"
  default = "sg-0f1aa8d6a20c61bd3"
  description = "The associated security groups."
}

variable "vpc_id" {
  type = "string"
  default = "vpc-0bfaa14e56fb3fcf5"
  description = "生成済み"
}

variable "subnet_id" {
  type = "string"
  default = "subnet-0fcc80915848c7e1f"
  description = "生成済み"
}

variable "volume_webserver_volume_size" {
  type = "string"
  default = "8"
  description = "生成済み"
}

variable "public_ssh_key_name" {
  description = "Name of the public SSH key used to connect to the virtual guest"
}

#variable "public_ssh_key" {
#  description = "Public SSH key used to connect to the virtual guest"
#}

# Ubuntu 14.04.01 as documented at https://cloud-images.ubuntu.com/releases/14.04/14.04.1/
