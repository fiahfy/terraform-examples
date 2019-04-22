terraform {
  backend "s3" {
    bucket = "<bucket>"
    key    = "simple-vpc/terraform.tfstate"
    region = "ap-northeast-1"
  }
}

provider "aws" {
  version = "~> 2.6"
  region = "ap-northeast-1"
}

variable "cidr" {}
variable "azs" { type = "list" }
variable "public_subnets" { type = "list" }
variable "private_subnets" { type = "list" }

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "simple-vpc"
  cidr = "${var.cidr}"

  azs             = "${var.azs}"
  public_subnets  = "${var.public_subnets}"
  private_subnets = "${var.private_subnets}"

#   assign_generated_ipv6_cidr_block = true

  enable_nat_gateway = true

  tags = {
    Terraform = "true"
    Environment = "${terraform.workspace}"
  }
}
