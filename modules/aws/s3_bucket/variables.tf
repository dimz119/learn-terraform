variable "environment" {
  description = "environment tag"
  default = "development"
  type        = string
}

variable "bucket_name" {
  description = "s3 bucket name"
  type        = string
}
