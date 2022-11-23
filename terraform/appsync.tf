resource "aws_appsync_graphql_api" "this" {
  authentication_type = "API_KEY"
  name                = "${local.name}-api"

  schema              = file("../schema.graphql")
}

resource "aws_appsync_api_key" "this" {
  api_id  = aws_appsync_graphql_api.this.id
  expires = "2022-05-03T00:00:00Z"
}

resource "aws_appsync_datasource" "dynanmodb" {
  api_id = aws_appsync_graphql_api.this.id
  name   = "${local.name}_dynanmodb"
  service_role_arn = aws_iam_role.appsync.arn
  type             = "AMAZON_DYNAMODB"
  description = "Allows access to DynamoDB table"

  dynamodb_config {
    table_name = aws_dynamodb_table.this.name
  }
}

resource "aws_appsync_datasource" "lambda" {
  api_id = aws_appsync_graphql_api.this.id
  name   = "${local.name}_lambda"
  service_role_arn = aws_iam_role.appsync.arn
  type             = "AWS_LAMBDA"

  description = "Allows access to lambda function"

  lambda_config {
    function_arn = aws_lambda_function.appsync_lambda.arn
  }
}

resource "aws_appsync_resolver" "orders" {
  api_id      = aws_appsync_graphql_api.this.id
  field       = "allOrders"
  type        = "Query"
  data_source = aws_appsync_datasource.dynanmodb.name

  request_template = file("../mapping-templates/dynamodb/orders-request.vtl")
  response_template = file("../mapping-templates/dynamodb/orders-response.vtl")
}

resource "aws_appsync_resolver" "get_orders" {
  api_id      = aws_appsync_graphql_api.this.id
  field       = "getOrder"
  type        = "Query"
  data_source = aws_appsync_datasource.dynanmodb.name

  request_template = file("../mapping-templates/dynamodb/get-order-request.vtl")
  response_template = file("../mapping-templates/dynamodb/get-order-response.vtl")
}

resource "aws_appsync_resolver" "add_shopify_thing" {
  api_id      = aws_appsync_graphql_api.this.id
  field       = "addToShopify"
  type        = "Mutation"
  data_source = aws_appsync_datasource.lambda.name

  request_template = file("../mapping-templates/lambda/shopify_update-request.vtl")
  response_template = file("../mapping-templates/lambda/shopify_update-response.vtl")
}

resource "aws_appsync_resolver" "add_orders" {
  api_id      = aws_appsync_graphql_api.this.id
  field       = "addOrder"
  type        = "Mutation"
  data_source = aws_appsync_datasource.dynanmodb.name

  request_template = file("../mapping-templates/dynamodb/add-order-request.vtl")
  response_template = file("../mapping-templates/dynamodb/add-order-response.vtl")
}