
# resource "aws_s3_bucket" "model_bucket" {
#   bucket = "my-huggingface-model-bucket"
# }

# resource "aws_ecr_repository" "model_repository" {
#   name = "my-huggingface-model-repo"
# }

resource "aws_lambda_function" "model_lambda" {
  function_name = "huggingface-inferentia2-lambda"
  handler      = "inference.handler"
  runtime      = "python3.8"
  code         = "${path.cwd}/huggingface.py"
  role         = aws_iam_role_lambda.arn
}

resource "aws_lambda_function_code" "model_archive" {
  zip_file = "path/to/your/model.zip"
}

resource "aws_iam_role" "lambda_role" {
  name = "huggingface-inferentia2-lambda-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_policy" {
  role       = aws_iam_role_lambda.arn
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"
}

resource "aws_sagemaker_model" "huggingface_model" {
  name = "huggingface-inferentia2-model"
  containers = [{
    image = aws_ecr_repository.model_repository.arn
    model_data_url = aws_s3_bucket.model_bucket.arn
  }]
}

resource "aws_sagemaker_endpoint_config" "huggingface_endpoint_config" {
  name = "huggingface-inferentia2-endpoint-config"
  production_variants = [{
    variant_name = "all"
    instance_type = "ml.inf1.xlarge"
    model_name    = aws_sagemaker_model.huggingface_model.name
  }]
}

resource "aws_sagemaker_endpoint" "huggingface_endpoint" {
  endpoint_config_name = aws_sagemaker_endpoint_config.huggingface_endpoint_config.name
}
