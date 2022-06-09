variable "azs" {
  type = string
  description = "The availability zones to use."
}

variable "region" {
  type = string
  default     = "us-east-1"
  description = "Region in which to create resources."
}

variable "environment" {
  type = string
  default = "Production"
  description = "It could be Dev/QA/Production"
}

variable "owner" {
  type = string
  default     = "Bits"
  description = "Owner of the instance"
}

variable "subnet_ids" {
  type = string
  description = "Auto scaling group subnet ids."
}

variable "vpc_cidr" {
  type = string
  description = "The primary network CIDR block."
}

variable "vpc_id" {
  type = string
  description = "VPC ID."
}

variable "s3_bucket" {
  type = string
  description = "Specify a bucket to files in."
}

variable "key_pair" {
  type = string
  default = "bits_key"
  description = "(optional) describe your variable"
}

variable "instance_type" {
  default = "t3.micro"
}

variable "ami" {
  description = "AMI for EC2"
}