resource "aws_dynamodb_table" "this" {
  name           = "Orders"
  billing_mode   = "PROVISIONED"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "orderId"
  range_key      = "emailAddress"

  attribute {
    name = "orderId"
    type = "S"
  }

  attribute {
    name = "emailAddress"
    type = "S"
  }

  attribute {
    name = "name"
    type = "S"
  }

  global_secondary_index {
    name               = "emailAddressIndex"
    hash_key           = "emailAddress"
    range_key          = "name"
    write_capacity     = 1
    read_capacity      = 1
    projection_type    = "INCLUDE"
    non_key_attributes = ["orderId"]
  }

  tags = {
    Name        = "Connor_AppSync_Demo"
    Environment = "Development"
  }
}
