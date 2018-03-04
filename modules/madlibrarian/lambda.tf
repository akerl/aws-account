resource "aws_iam_role_policy" "lambda_perms" {
  name   = "lambda_perms"
  role   = "${aws_iam_role.madlibrarian_lambda.name}"
  policy = "${data.aws_iam_policy_document.lambda_perms.json}"
}

resource "aws_iam_role" "madlibrarian_lambda" {
  name               = "madlibrarian_lambda_${var.data-bucket}"
  assume_role_policy = "${data.aws_iam_policy_document.lambda_assume.json}"
}

resource "aws_lambda_function" "madlibrarian_lambda" {
  s3_bucket     = "${var.lambda-bucket}"
  s3_key        = "lambdas/payload-${chomp(file("${path.module}/version"))}.zip"
  function_name = "madlibrarian_lambda_${var.data-bucket}"
  role          = "${aws_iam_role.madlibrarian_lambda.arn}"
  handler       = "main"
  runtime       = "go1.x"
  timeout       = 10
}

resource "aws_lambda_permission" "allow_api_gateway" {
  function_name = "${aws_lambda_function.madlibrarian_lambda.function_name}"
  statement_id  = "AllowExecutionFromApiGateway"
  action        = "lambda:InvokeFunction"
  principal     = "apigateway.amazonaws.com"
  source_arn    = "arn:aws:execute-api:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:${aws_api_gateway_rest_api.api.id}/*"
}

data "aws_caller_identity" "current" {}

data "aws_region" "current" {}
