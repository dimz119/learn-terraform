variable "filename" {
    default = "/tmp/hello.txt"
    type = string
    description = "local file name"
}

variable "content" {
    default = "Hello World"
}

# variable "server" {
#   type = object({
#     name         = string
#     instance_type = string
#     ami          = string
#     subnet_id    = string
#     security_group_ids = list(string)
#     tags = map(string)
#   })
#   default = {
#     name         = "my-server"
#     instance_type = "t2.micro"
#     ami          = "ami-xxxxxxxx"
#     subnet_id    = "subnet-xxxxxxx"
#     security_group_ids = ["sg-xxxxxxxx"]
#     tags         = {
#       Environment = "production"
#       Application = "my-app"
#     }
#   }
# }

# resource "aws_instance" "ec2" {
#   ami           = var.server.ami
#   instance_type = var.server.instance_type
#   subnet_id     = var.server.subnet_id
#   vpc_security_group_ids = var.server.security_group_ids
#   key_name      = "my-keypair"
#   tags          = var.server.tags

#   count = 1
# }

# # tuple
# variable "example_tuple" {
#   type = tuple([string, number, bool])
#   default = ["my_string", 23, true]
# }

# output "tuple_example" {
#   value = var.example_tuple[0] // returns "my_string"
# }

# # set
# variable "example_set" {
#   type = set(string)
#   default = ["v1", "v2", "v3"]
# }

# output "set_example" {
#   value = var.my_set
# }

# variable "any_example" {
#   type = any
#   default = {
#     name         = "my-resource"
#     instance_type = "t2.micro"
#     ami          = "ami-xxxxx"
#     subnet_id    = "subnet-xxxxxx"
#     security_group_ids = ["sg-xxxxxx"]
#     tags         = {
#       Environment = "production"
#       Application = "my-app"
#     }
#   }
# }

# resource "aws_instance" "ec2" {
#   ami           = var.any_example.ami
#   instance_type = var.any_example.instance_type
#   subnet_id     = var.any_example.subnet_id
#   vpc_security_group_ids = var.any_example.security_group_ids
#   key_name      = "my-keypair"
#   tags          = var.v.tags

#   count = 1
# }