# # local_file: provider, resource type
# # hello: resource name
# resource "local_file" "hello" {
#     filename = "/tmp/hello.txt"
#     content = "hello world"
#     file_permission = "0700"
# }