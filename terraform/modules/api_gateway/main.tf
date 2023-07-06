resource "aws_apigatewayv2_api" "s3_proxy" {
  name          = "${var.api_gateway_name}"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_stage" "v1" {
  api_id      = aws_apigatewayv2_api.s3_proxy.id
  name        = "v1"
  auto_deploy = true
}

resource "aws_apigatewayv2_integration" "s3_proxy" {
  api_id             = aws_apigatewayv2_api.s3_proxy.id
  integration_type   = "AWS_PROXY"
  connection_type    = "INTERNET"
  description        = var.description
  integration_method = var.integration_method
  integration_uri    = var.integration_uri
}

resource "aws_apigatewayv2_route" "s3_proxy" {
  api_id         = aws_apigatewayv2_api.s3_proxy.id
  operation_name = var.operation_name
  route_key      = "${var.method} /url/{filename}"
  target         = "integrations/${aws_apigatewayv2_integration.s3_proxy.id}"
}