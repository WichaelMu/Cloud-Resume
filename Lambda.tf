
data "aws_iam_policy_document" "m-lambda" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "LambdaIAM" {
  name               = "LambdaIAM"
  assume_role_policy = data.aws_iam_policy_document.m-lambda.json
}

variable "PayloadName" {
  default = "Payload.zip"
}

data "archive_file" "Archive" {
  type        = "zip"
  source_file = "Source/Python/LambdaFunction.py"
  output_path = var.PayloadName
}

resource "aws_lambda_function" "m" {
  function_name = "IncrementVisitorMetric"
  filename      = var.PayloadName
  role          = aws_iam_role.LambdaIAM.arn

  source_code_hash = data.archive_file.Archive.output_base64sha256

  handler = "LambdaFunction.py"
  runtime = "python3.9"
}