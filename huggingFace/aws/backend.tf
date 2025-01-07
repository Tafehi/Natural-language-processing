terraform {
  backend "s3" {
    bucket  = "terraform-state-bucket"
    encrypt = true
    key    = "sagemaker/terraform.tfstate"
    region = "eu-west-1"
    #    dynamodb_table = "terraform_backend_lock"
  }
}
