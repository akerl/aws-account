terraform {
  required_providers {
    aws = {
      version = "3.4.0"
    }
  }
}

data "aws_iam_policy_document" "trust_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "lambda" {
  name               = "hass_lambda"
  assume_role_policy = data.aws_iam_policy_document.trust_policy.json
}

resource "aws_iam_role_policy_attachment" "lambda" {
  role       = aws_iam_role.lambda.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_lambda_function" "lambda" {
  filename         = "./hass/payload.zip"
  function_name    = "hass"
  role             = aws_iam_role.lambda.arn
  handler          = "lambda_function.lambda_handler"
  source_code_hash = filebase64sha256("./hass/payload.zip")
  runtime          = "python3.8"
  environment {
    variables = {
      BASE_URL = "https://hass.a-rwx.org"
    }
  }
}

resource "aws_lambda_permission" "allow_alexa" {
  statement_id       = "AllowExecutionFromAlexa"
  action             = "lambda:InvokeFunction"
  function_name      = aws_lambda_function.lambda.function_name
  principal          = "alexa-connectedhome.amazon.com"
  event_source_token = "amzn1.ask.skill.abac7b2d-2bfd-4952-8501-efe3206d0b23"
}
