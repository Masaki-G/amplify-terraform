variable "aws_access_key_id" {}
variable "aws_secret_access_key" {}

terraform {
  required_version = "0.15.2"

  required_providers {
    aws  = "3.53.0"
    null = "3.1.0"
  }
}

provider "aws" {
  access_key = var.aws_access_key_id
  secret_key = var.aws_secret_access_key
  region     = var.region
}

provider "aws" {
  alias      = "east"
  access_key = var.aws_access_key_id
  secret_key = var.aws_secret_access_key
  region     = "us-east-1"
}





