resource "aws_iam_role_policy" "lambda_perms" {
  name   = "lambda_perms"
  role   = "${aws_iam_role.lambda.name}"
  policy = "${data.aws_iam_policy_document.lambda_perms.json}"
}

resource "aws_iam_role" "lambda" {
  name               = "go-hello-linodians"
  assume_role_policy = "${data.aws_iam_policy_document.lambda_assume.json}"
}

resource "aws_lambda_function" "lambda" {
  s3_bucket     = "${var.lambda-bucket}"
  s3_key        = "lambdas/payload-${chomp(file("${path.module}/version"))}.zip"
  function_name = "go-hello-linodians"
  role          = "${aws_iam_role.lambda.arn}"
  handler       = "main"
  runtime       = "go1.x"
  timeout       = 50

  environment {
    variables = {
      S3_BUCKET = "${var.data-bucket}"
      S3_KEY    = "config.yaml"
    }
  }
}
