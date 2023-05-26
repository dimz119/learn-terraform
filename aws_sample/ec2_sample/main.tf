provider "aws" {
  region = "us-west-2"
}

# data "aws_ami" "ubuntu" {
#   most_recent = true

#   filter {
#     name   = "name"
#     values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
#   }

#   filter {
#     name   = "virtualization-type"
#     values = ["hvm"]
#   }

#   owners = ["099720109477"] # Canonical
# }

# # aws ec2 create-default-subnet --availability-zone us-west-2a
# resource "aws_instance" "web" {
#   ami           = data.aws_ami.ubuntu.id
#   instance_type = "t3.micro"

#   tags = {
#     Name = "HelloWorld"
#   }
# }

resource "aws_instance" "web" {
  ami           = "ami-0ab193018f3e9351b"
  instance_type = "t3.micro"

  tags = {
    Name = "HelloWorld"
  }
}