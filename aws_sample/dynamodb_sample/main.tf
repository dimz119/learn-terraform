provider "aws" {
  region = "us-west-2"
}

resource "aws_dynamodb_table" "state-lock-table" {
    name = "state-lock"
    billing_mode = "PAY_PER_REQUEST"
    hash_key = "LockID"
    attribute {
      name = "LockID"
      type = "S"
    }
}