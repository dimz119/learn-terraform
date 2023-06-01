module "s3_bucket" {
  source      = "../../modules/aws/s3_bucket" # Path to the module directory
  bucket_name = "learn-terraform-bucket"
  environment = "development"
}

module "s3_bucket2" {
  source      = "../../modules/aws/s3_bucket" # Path to the module directory
  bucket_name = "learn-terraform-bucket2"
  environment = "development"
}


output "s3_bucket_name" {
  value = module.s3_bucket.bucket_name
}

module "http_80_security_group" {
  source  = "terraform-aws-modules/security-group/aws//modules/http-80"
  version = "~> 4.0"

  name                = "http_80_sg"
  vpc_id              = "vpc-0614a8621db180ede"
  ingress_cidr_blocks = ["0.0.0.0/0"]
}
