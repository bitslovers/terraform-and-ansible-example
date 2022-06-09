terraform {
  required_providers {
    aws = {
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket  = "s3-for-terraform-remote-state"
    key     = "webserver/prod/us-east-1/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}

data "aws_vpc" "vpc" {
  id = var.vpc_id
}

module "webserver" {
  source                    = "./webserver"
  azs                       = "${var.azs}"
  subnet_ids                = var.subnet_ids
  vpc_id                    = "${data.aws_vpc.vpc.id}"
  vpc_cidr                  = "${data.aws_vpc.vpc.cidr_block}"
  s3_bucket                 = var.s3_bucket
  key_pair                  = var.key_pair
  instance_type             = var.instance_type
  ami                       = var.ami
}
