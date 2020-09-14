variable "system_tag" {
  description = "システムの識別子 初期値：WebSysXX"
  default     = "WebSys"
}


variable "aws_region" {
  description = "AWS region to launch servers. Default：ap-northeast-1"
  default     = "ap-northeast-1"
}

variable "webserver_ami" {
  default    = "ami-0d09d267328197c99"
  description = "マシンイメージ 初期値：CentOS 7.8.2003 x86_64"
}

variable "webserver_aws_instance_type" {
  default = "t2.small"
  description = "インスタンスタイプ 初期値：t2.small"
}

variable "availability_zone01" {
  default     = "ap-northeast-1a"
  description = "アベイラビリティゾーン 初期値：ap-northeast-1a"
}

variable "availability_zone02" {
  default     = "ap-northeast-1c"
  description = "アベイラビリティゾーン 初期値：ap-northeast-1c"
}


variable "webserver_name" {
  default     = "Webserver"
  description = "インスタンス名 初期値：WebserverXX"
}

variable "security_group_id" {
  default = "sg-0f1aa8d6a20c61bd3"
  description = "The associated security groups. Default：sg-0f1aa8d6a20c61bd3"
}

variable "vpc_id" {
  default = "vpc-0bfaa14e56fb3fcf5"
  description = "VPC 初期値：vpc-0bfaa14e56fb3fcf5"
}

variable "subnet_id01" {
  default = "subnet-0fcc80915848c7e1f"
  description = "インスタンス配置先サブネット 初期値：subnet-0fcc80915848c7e1f（ap-northeast-1a）"
}

variable "subnet_id02" {
  default = "subnet-0ad19fbd59cd5b0a4"
  description = "インスタンス配置先サブネット 初期値：subnet-0ad19fbd59cd5b0a4（ap-northeast-1c）"
}

variable "volume_webserver_volume_size" {
  default = "8"
  description = "インスタンス用ボリュームサイズ（GB） 初期値：8GB"
}

variable "public_ssh_key_name" {
  description = "Name of the public SSH key used to connect to the virtual guest. Default：mcm-test-key"
  default = "mcm-test-key"
}

variable "instance_list" {
  type = "list"
  default = ["${aws_instance.webserver01.id}","${aws_instance.webserver02.id}"]
  description = "ALBに紐づけるインスタンスリスト"
}

#variable "public_ssh_key" {
#  description = "Public SSH key used to connect to the virtual guest"
#}

# Ubuntu 14.04.01 as documented at https://cloud-images.ubuntu.com/releases/14.04/14.04.1/
