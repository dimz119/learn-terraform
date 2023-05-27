provider "aws" {
  region = "us-west-2"
}

resource "aws_instance" "web" {
  ami           = "ami-0ab193018f3e9351b"
  instance_type = "t3.micro"

  tags = {
    Name = "HelloWorld"
  }
}

# resource "aws_s3_bucket" "learn-terraform-ourbucket" {
#   bucket = "learn-terraform-ourbucket"
# }