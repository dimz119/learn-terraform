packer {
  required_plugins {
    amazon = {
      source  = "github.com/hashicorp/amazon"
      version = "~> 1"
    }
  }
}

variable "aws_access_key" {
  type    = string
  default = "${env("AWS_ACCESS_KEY_ID")}"
}

variable "aws_secret_key" {
  type    = string
  default = "${env("AWS_SECRET_ACCESS_KEY")}"
}

source "amazon-ebs" "example" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region     = "us-west-1"

  source_ami_filter {
    filters = {
      "virtualization-type" = "hvm"
      "name"                = "amzn2-ami-hvm-2.0.*.0-x86_64-ebs"
      "root-device-type"    = "ebs"
    }
    owners      = ["137112412989"]
    most_recent = true
  }

  instance_type = "t2.micro"
  ssh_username  = "ec2-user"
  ami_name      = "packer-example"
}

build {
  sources = [
    "source.amazon-ebs.example"
  ]

  provisioner "shell" {
    inline = [
      "sudo yum update -y",
      "sudo yum install -y httpd",
      "sudo systemctl start httpd",
      "sudo systemctl enable httpd",
      "echo '<h1>Hello, World from Packer!</h1>' | sudo tee /var/www/html/index.html"
    ]
  }
}
