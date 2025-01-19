provider "aws" {
  region = var.aws_region
}


resource "aws_dynamodb_table" "tf_states_ddb_table" {
  name             = "tf_states_raulmoldes"
  billing_mode     = "PAY_PER_REQUEST"
  hash_key         = "LockID"
  stream_enabled   = true
  stream_view_type = "NEW_AND_OLD_IMAGES"

  attribute {
    name = "LockID"
    type = "S"
  }
  tags = {
    Name        = "tf-states-raulmoldes"
    CreatedBy   = "raul.moldes.work@gmail.com"
    Description = "DynamoDB table used to store Terraform state locks."

  }

}
