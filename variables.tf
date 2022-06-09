variable "azs" {
  description = "The availability zones to use."
}

variable "subnet_ids" {
  description = "Private subnet ids."
}

variable "environment" {
  description = "This tag should define whether the instance is a Medical or a Non-Medical instance. The only acceptable values are Medical and Non-Medical"
}

variable "key_pair" {
  description = "Key Pair for EC2/SSH"
}

variable "instance_type" {
  default = "t3.micro"
}

variable "ami" {
  description = "AMI for EC2"
}

variable "vpc_id" {
  description = "The existing VPC ID"
}

variable s3_bucket {
  description = "S3 for Remote State and to store the Ansible Scripts"
}