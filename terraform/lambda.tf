

resource "aws_lambda_function" "appsync_lambda" {
  filename      = "../build/payload.zip"
  function_name = "${local.name}-lambda-function"
  role          = aws_iam_role.lambda.arn
  handler       = "shopify-update.handler"

  # The filebase64sha256() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the base64sha256() function and the file() function:
  # source_code_hash = "${base64sha256(file("lambda_function_payload.zip"))}"
  source_code_hash = filebase64sha256("../build/payload.zip")

  runtime = "nodejs12.x"
}