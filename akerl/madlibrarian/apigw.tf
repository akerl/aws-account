data "aws_iam_policy_document" "apigw_assume" {
  statement {
    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type = "Service"

      identifiers = [
        "apigateway.amazonaws.com",
      ]
    }
  }
}

data "aws_iam_policy_document" "apigw_perms" {
  statement {
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:DescribeLogGroups",
      "logs:DescribeLogStreams",
      "logs:FilterLogEvents",
      "logs:GetLogEvents",
      "logs:PutLogEvents",
    ]

    resources = [
      "arn:aws:logs:*:*:*",
    ]
  }
}

resource "aws_iam_role_policy" "apigw_perms" {
  name   = "apigw_perms"
  role   = "${aws_iam_role.madlibrarian_apigw.name}"
  policy = "${data.aws_iam_policy_document.apigw_perms.json}"
}

resource "aws_iam_role" "madlibrarian_apigw" {
  name               = "madlibrarian_apigw"
  assume_role_policy = "${data.aws_iam_policy_document.apigw_assume.json}"
}

resource "aws_api_gateway_account" "account" {
  cloudwatch_role_arn = "${aws_iam_role.madlibrarian_apigw.arn}"
}

resource "aws_api_gateway_rest_api" "api" {
  name = "madlibrarian"
}

resource "aws_api_gateway_resource" "endpoint" {
  rest_api_id = "${aws_api_gateway_rest_api.api.id}"
  parent_id   = "${aws_api_gateway_rest_api.api.root_resource_id}"
  path_part   = "{story}"
}

resource "aws_api_gateway_method" "method" {
  rest_api_id   = "${aws_api_gateway_rest_api.api.id}"
  resource_id   = "${aws_api_gateway_resource.endpoint.id}"
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_method_settings" "settings" {
  rest_api_id = "${aws_api_gateway_rest_api.api.id}"
  stage_name  = "${aws_api_gateway_stage.stage.stage_name}"
  method_path = "${aws_api_gateway_resource.endpoint.path_part}/${aws_api_gateway_method.method.http_method}"

  settings {
    metrics_enabled = true
    logging_level   = "INFO"
  }
}

resource "aws_api_gateway_integration" "integration" {
  rest_api_id             = "${aws_api_gateway_rest_api.api.id}"
  resource_id             = "${aws_api_gateway_resource.endpoint.id}"
  http_method             = "${aws_api_gateway_method.method.http_method}"
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "${aws_lambda_function.madlibrarian_lambda.invoke_arn}"
}

resource "aws_api_gateway_deployment" "deployment" {
  depends_on = [
    "aws_api_gateway_method.method",
    "aws_api_gateway_integration.integration",
  ]

  rest_api_id = "${aws_api_gateway_rest_api.api.id}"
  stage_name  = "api"

  variables {
    bucket = "${var.data-bucket}"
  }
}

resource "aws_api_gateway_stage" "stage" {
  stage_name    = "prod"
  rest_api_id   = "${aws_api_gateway_rest_api.api.id}"
  deployment_id = "${aws_api_gateway_deployment.deployment.id}"

  variables {
    bucket = "${var.data-bucket}"
  }
}

output "url" {
  value = "${aws_api_gateway_stage.stage.invoke_url}"
}
