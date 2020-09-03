variable "aws_region" {
  description = "AWS region to launch servers."
  default     = "us-east-1"
}

variable "aws_image_size" {
  description = "AWS Image Instance Size"
  default     = "t2.small"
}

variable "public_ssh_key" {
  description = "Public SSH key used to connect to the virtual guest"
}

variable "webserver01_ami" {
  type = "string"
  description = "生成済み"
}

variable "webserver01_aws_instance_type" {
  type = "string"
  description = "生成済み"
}

variable "availability_zone" {
  type = "string"
  description = "生成済み"
}

variable "webserver01_name" {
  type = "string"
  description = "生成済み"
}

variable "aws_key_pair_name" {
  type = "string"
  description = "生成済み"
}

variable "volume_webserver01_volume_size" {
  type = "string"
  description = "生成済み"
}

variable "security_group_id" {
  type = "string"
  description = "The associated security groups."
}

variable "webserver01_connection_user" {
  type = "string"
  default = "root"
}

variable "webserver01_connection_private_key" {
  type = "string"
  default = "key_value"
}

# Ubuntu 14.04.01 as documented at https://cloud-images.ubuntu.com/releases/14.04/14.04.1/
