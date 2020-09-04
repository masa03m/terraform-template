variable "aws_region" {
  description = "AWS region to launch servers."
  default     = "ap-northeast-1"
}

variable "webserver01_ami" {
  type = "string"
  default    = "ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-20200810"
  description = "生成済み"
}

variable "webserver01_aws_instance_type" {
  type = "string"
  default = "t2.small"
  description = "生成済み"
}

variable "availability_zone" {
  type = "string"
  default     = "ap-northeast-1a"
  description = "生成済み"
}

variable "webserver01_name" {
  type = "string"
  default     = "webserver01"
  description = "生成済み"
}

variable "aws_key_pair_name" {
  type = "string"
  default     = "nic-mori"
  description = "生成済み"
}

variable "security_group_id" {
  type = "string"
  default = "default"
  description = "The associated security groups."
}

variable "subnet_id" {
  type = "string"
  default = "mcm-test-subnet"
  description = "生成済み"
}

variable "volume_webserver1_volume_size" {
  type = "string"
  default = "8GB"
  description = "生成済み"
}

# Ubuntu 14.04.01 as documented at https://cloud-images.ubuntu.com/releases/14.04/14.04.1/
