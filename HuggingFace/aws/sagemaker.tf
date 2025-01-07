resource "aws_sagemaker_model" "customHuggingface" {
  name = var.name
  execution_role_arn = aws_iam_role.sagemaker_role.arn
  primary_container {
    image          = "${data.aws_caller_identity.current.account_id}.dkr.ecr.${data.aws_region.current.name}.amazonaws.com/${var.image}:latest"
    model_data_url = "s3://${lookup(var.bucket, terraform.workspace)}/NLP/model.tar.gz"
  }
}


data "aws_iam_policy_document" "assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["sagemaker.amazonaws.com"]
    }
  }
}


resource "aws_iam_role" "sagemaker_role" {
  name               = "${var.name}-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

data "aws_iam_policy_document" "InferenceAcess" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["arn:aws:s3:::${lookup(var.bucket, terraform.workspace)}/*"]
  }
  statement {
    actions = [
      "ecr:GetAuthorizationToken",
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:GetRepositoryPolicy",
      "ecr:SetRepositoryPolicy",
      "ecr:DescribeRepositories",
      "ecr:ListImages",
      "ecr:DescribeImages",
      "ecr:BatchGetImage",
      "ecr:GetLifecyclePolicy",
      "ecr:GetLifecyclePolicyPreview",
      "ecr:ListTagsForResource",
      "ecr:DescribeImageScanFindings",
      "ecr:InitiateLayerUpload",
    ]

    resources = ["${data.aws_caller_identity.current.account_id}.dkr.ecr.${data.aws_region.current.name}.amazonaws.com/${var.image}:latest"]
  }
  statement {
    resources = ["*"]
    actions = [
      "cloudwatch:PutMetricData",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:CreateLogGroup",
      "logs:DescribeLogStreams",
    ]
  }
}

resource "aws_iam_policy" "InferenceAcess" {
  name        = "InferenceAcess"
  policy      = data.aws_iam_policy_document.InferenceAcess.json
}

resource "aws_iam_role_policy_attachment" "InferenceAcess" {
  role       = aws_iam_role.sagemaker_role.name
  policy_arn = aws_iam_policy.InferenceAcess.arn
}
resource "aws_sagemaker_endpoint_configuration" "customHuggingface" {
  name = "customHuggingface"

  production_variants {
    variant_name           = "Inferentia2"
    model_name             = aws_sagemaker_model.customHuggingface.name
    initial_instance_count = 1
    instance_type          = "ml.inf2.24xlarge"
  }

}

resource "aws_sagemaker_endpoint" "customHuggingface" {
  name                 = "customHuggingface"
  endpoint_config_name = aws_sagemaker_endpoint_configuration.customHuggingface.name
}