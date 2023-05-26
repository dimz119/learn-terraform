terraform {
    backend "s3" {
        bucket = "learn-terraform-remote-state"
        key = "terraform.tfstate"
        region = "us-west-2"
        dynamodb_table = "state-lock"
    }
}