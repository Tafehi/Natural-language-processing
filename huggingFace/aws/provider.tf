
provider "aws" {
  region = "eu-west-1"
  default_tags {
    tags = {
      CreatedBy   = "Terraform"
      Owner       = "Ehsan Tafehi"
      Project     = "NLP"
      environment = terraform.workspace
      Group       = ""
    }
  }
}
