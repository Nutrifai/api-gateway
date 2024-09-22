resource "aws_lambda_function" "authorizer" {
  function_name    =   var.lambda_authorizer_name
  handler          = "lambda_function.lambda_handler"
  runtime          = "python3.11"
  role             = aws_iam_role.lambda_authorizer_role.arn
  filename         = data.archive_file.code.output_path
  source_code_hash = data.archive_file.code.output_base64sha256
  layers           = [aws_lambda_layer_version.requirements_lambda_layer.arn]
  timeout          = 29 # seconds

  environment {
    variables = {
      "ENVIRONMENT" = "dev"
    }
  } 
}

 
data "archive_file" "code" {
  type        = "zip"
  source_dir  = "${local.source_code_path}"
  excludes    = ["venv"]
  output_path = "${path.module}/outputs/code.zip"
}