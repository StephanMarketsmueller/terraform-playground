terraform {
  backend "s3" {
    bucket = "tfstate-bucket-0815"
    key = "stage/data-stores/mysql/terraform.tfstate"
    region = "eu-central-1"

    dynamodb_table = "tfstate-locks-0815"
    encrypt = true
  }
}

provider "aws" {
  region = "eu-central-1"
}

resource "aws_db_instance" "example" {
  identifier_prefix = "terraform-up-and-running"
  engine = "mysql"
  allocated_storage = 10
  instance_class = "db.t2.micro"
  name = "example_database"
  username = "admin"

  password = jsondecode(data.aws_secretsmanager_secret_version.db_password.secret_string)["db_password"]
}

data "aws_secretsmanager_secret_version" "db_password" {
    secret_id = "mysql-master-password-stage"
  
}