terraform {
  backend "s3" {
    bucket  = "terraform-state-bucket-et"
    encrypt = true
    key    = "sagemaker/terraform.tfstate"
    region = "eu-north-1"
    #    dynamodb_table = "terraform_backend_lock"
  }
}
