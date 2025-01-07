variable "name" {
  description = "sagemake endpoint name"
  default = "huggingface-nlp"
}

variable "bucket" {
  type = map(string)
  default = {
    dev = "dev-sagmemaker"
    test = "test-sagemaker"
    uat = "test-sagemaker"
    prod = "prod-sagemaker"
  }
}