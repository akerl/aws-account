data "aws_iam_policy_document" "lambda_assume" {
  statement {
    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type = "Service"

      identifiers = [
        "lambda.amazonaws.com",
      ]
    }
  }
}

data "aws_iam_policy_document" "lambda_perms" {
  statement {
    actions = [
      "s3:ListBucket",
      "s3:GetObject",
    ]

    resources = [
      "arn:aws:s3:::${var.data-bucket}/*",
      "arn:aws:s3:::${var.data-bucket}",
    ]
  }

  statement {
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]

    resources = [
      "arn:aws:logs:*:*:*",
    ]
  }
}

resource "aws_iam_role_policy" "lambda_perms" {
  name   = "lambda_perms"
  role   = "${aws_iam_role.lambda.name}"
  policy = "${data.aws_iam_policy_document.lambda_perms.json}"
}

resource "aws_iam_role" "lambda" {
  name               = "${var.data-bucket}_lambda"
  assume_role_policy = "${data.aws_iam_policy_document.lambda_assume.json}"
}

resource "aws_lambda_function" "lambda" {
  s3_bucket     = "${var.lambda-bucket}"
  s3_key        = "lambdas/payload-${chomp(file("${path.module}/version"))}.zip"
  function_name = "${var.data-bucket}"
  role          = "${aws_iam_role.lambda.arn}"
  handler       = "main"
  runtime       = "go1.x"
  timeout       = 50

  environment {
    variables = {
      S3_BUCKET = "${var.data-bucket}"
      S3_KEY    = "config/urls"
    }
  }
}
