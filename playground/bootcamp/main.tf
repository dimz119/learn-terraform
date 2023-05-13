# local_file: provider, resource type
# hello: resource name
resource "local_file" "hello" {
    filename = var.filename
    # content = var.content
    content = "${random_string.random_code.id}"
    file_permission = "0700"
    depends_on = [
      random_string.random_code
    ]
}

resource "random_string" "random_code" {
  length  = 5
  special = false
  upper   = false
}

output random_code_output {
  value = random_string.random_code.id
  description = "This value will be the id of random_string.random_code"
}

# with cli argument
# terraform plan -var="filename='/tmp/world.txt'" -var="content='hi hi hi'"

# with environment variable
# export TF_VAR_filename=/tmp/world1.txt && terraform plan
