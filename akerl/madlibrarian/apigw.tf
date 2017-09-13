resource "aws_api_gateway_rest_api" "api" {
  name = "madlibrarian"
}

resource "aws_api_gateway_resource" "endpoint" {
  rest_api_id = "${aws_api_gateway_rest_api.api.id}"
  parent_id = "${aws_api_gateway_rest_api.api.root_resource_id}"
  path_part = "{story}"
}

resource "aws_api_gateway_method" "method" {
  rest_api_id   = "${aws_api_gateway_rest_api.api.id}"
  resource_id   = "${aws_api_gateway_resource.endpoint.id}"
  http_method   = "GET"
  authorization = "NONE"

  request_parameters {
    "method.request.path.story" = true
  }
}

resource "aws_api_gateway_integration" "integration" {
  rest_api_id             = "${aws_api_gateway_rest_api.api.id}"
  resource_id             = "${aws_api_gateway_resource.endpoint.id}"
  http_method             = "${aws_api_gateway_method.method.http_method}"
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "${aws_lambda_function.madlibrarian_lambda.invoke_arn}"

  request_parameters {
    "integration.request.path.story" = "method.request.path.story"
  }
}

resource "aws_api_gateway_deployment" "prod" {
  rest_api_id = "${aws_api_gateway_rest_api.api.id}"
  stage_name = "api"
}

output "url" {
  value = "https://${aws_api_gateway_deployment.prod.rest_api_id}.execute-api.us-east-1.amazonaws.com/${aws_api_gateway_deployment.prod.stage_name}"
}
