terraform {
  backend "s3" {
    bucket = "tfstate-bucket-0815"
    key = "workspace-example/terraform.tfstate"
    region = "eu-central-1"

    dynamodb_table = "tfstate-locks-0815"
    encrypt = true
  }
}

provider "aws" {
  region = "eu-central-1"
}

resource "aws_instance" "example" {
  ami        = "ami-00d5e377dd7fad751"
  instance_type   = "t2.micro"
  
}