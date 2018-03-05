resource "aws_iam_role_policy" "lambda_perms" {
  name   = "lambda_perms"
  role   = "${aws_iam_role.github-auth-lambda.name}"
  policy = "${data.aws_iam_policy_document.lambda_perms.json}"
}

resource "aws_iam_role" "github-auth-lambda" {
  name               = "github-auth-lambda_${var.data-bucket}"
  assume_role_policy = "${data.aws_iam_policy_document.lambda_assume.json}"
}

resource "aws_lambda_function" "github-auth-lambda" {
  s3_bucket     = "${var.lambda-bucket}"
  s3_key        = "lambdas/payload-${chomp(file("${path.module}/version"))}.zip"
  function_name = "github-auth-lambda_${var.data-bucket}"
  role          = "${aws_iam_role.github-auth-lambda.arn}"
  handler       = "main"
  runtime       = "go1.x"
  timeout       = 10

  environment {
    variables = {
      S3_BUCKET = "${var.data-bucket}"
      S3_KEY    = "config.yaml"
    }
  }
}

resource "aws_lambda_permission" "allow_api_gateway" {
  function_name = "${aws_lambda_function.github-auth-lambda.function_name}"
  statement_id  = "AllowExecutionFromApiGateway"
  action        = "lambda:InvokeFunction"
  principal     = "apigateway.amazonaws.com"
  source_arn    = "arn:aws:execute-api:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:${aws_api_gateway_rest_api.api.id}/*"
}
