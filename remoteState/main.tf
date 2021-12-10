terraform {
  backend "s3" {
    bucket = "tfstate-bucket-0815"
    key = "global/s3/terraform.tfstate"
    region = "eu-central-1"

    dynamodb_table = "tfstate-locks-0815"
    encrypt = true
  }
}
provider "aws" {
  region = "eu-central-1"
  # Allow any 2.x version of the AWS provider
}

resource "aws_s3_bucket" "terraform_state" {

  bucket = "tfstate-bucket-0815"

  # Enable versioning so we can see the full revision history of our
  # state files
  versioning {
    enabled = true
  }

  # Enable server-side encryption by default
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_dynamodb_table" "terraform_locks" {
  name         = "tfstate-locks-0815"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}
