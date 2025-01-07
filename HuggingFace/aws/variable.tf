variable "name" {
  description = "sagemake endpoint name"
  default = "huggingface-nlp"
}

variable "bucket" {
  type = map(string)
  default = {
    dev = "dev-sagmemaker"
    test = "test-sagemaker"
    uat = "uat-sagemaker"
    prod = "prod-sagemaker"
  }
}

variable "image" {
  default = "huggingface"
}