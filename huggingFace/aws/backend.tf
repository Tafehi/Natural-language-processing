# terraform {
#   backend "s3" {
#     bucket  = "terraform-state-bucket"
#     encrypt = true
#     key    = "sagemaker/terraform.tfstate"
#     region = "eu-west-1"
#     #    dynamodb_table = "terraform_backend_lock"
#   }
# }

terraform {
  backend "s3" {
    bucket  = "fvc-terraform-state-bucket-dev"
    encrypt = true
    #"allente-terrafrom-sandbox/logstash/" 
    key    = "sagemaker/terraform.tfstate"
    region = "eu-west-1"
    #    dynamodb_table = "terraform_backend_lock"
  }
}