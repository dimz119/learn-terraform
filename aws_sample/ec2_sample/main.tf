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

# resource "aws_instance" "web" {
#   ami           = "ami-0ab193018f3e9351b"
#   instance_type = "t3.micro"

#   tags = {
#     Name = "HelloWorld"
#   }
# }

resource "aws_instance" "web" {
  ami           = "ami-0ab193018f3e9351b"
  instance_type = "t3.micro"

  tags = {
    Name = "web server"
  }

  key_name = aws_key_pair.web.id

  # for aws_instance only
  # azure: custom_data
  # gcp: meta_data
  # user_data = <<-EOF
  #   #! /bin/bash
  #   sudo yum update
  #   sudo yum install nginx -y
  #   sudo service nginx start
  #   sudo chkconfig nginx on
  #   sudo service nginx status
  # EOF

  provisioner "remote-exec" {
    inline = [
      "sudo yum update",
      "sudo yum install nginx -y",
      "sudo service nginx start",
      "sudo chkconfig nginx on"
    ]
  }
  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ec2-user"
    private_key = file("/Users/seungjoonlee/.ssh/id_rsa")
  }

  provisioner "local-exec" {
    on_failure = fail
    command = "echo ${aws_instance.web.public_ip} >> /tmp/public_ip.txt"
  }

  provisioner "local-exec" {
    when = destroy
    command = "rm -f /tmp/public_ip.txt"
  }

  vpc_security_group_ids = [aws_security_group.ssh-access.id, aws_security_group.nginx-access.id]
}

resource "aws_key_pair" "web" {
  public_key = file("/Users/seungjoonlee/.ssh/id_rsa.pub")
}

resource "aws_security_group" "ssh-access" {
  name = "ssh-access"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "nginx-access" {
  name = "nginx-access"
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

output "publicip" {
  value = aws_instance.web.public_ip
}