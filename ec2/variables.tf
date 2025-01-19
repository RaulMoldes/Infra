variable "server_port" {
  description = "The port the server will listen on"
  type        = number
  default     = 8080

  validation {
    condition     = var.server_port > 0 && var.server_port < 65536
    error_message = "Port number must be between 1 and 65535"
  }

  sensitive = false
}


variable "aws_region" {
  description = "The AWS region to deploy to"
  type        = string
  default     = "eu-west-1"
  sensitive   = false
}

variable "terraform_backend_s3_bucket" {

  description = "The S3 bucket to store Terraform state"
  type        = string
  default     = "tf_states_bucket"
  sensitive   = false
}

variable "terraform_backend_dynamodb_table" {

  description = "The DynamoDB table to store Terraform state locks"
  type        = string
  default     = "tf_states_ddb_table"
  sensitive   = false
}

variable "terraform_backend_s3_bucket_prefix" {

  description = "The prefix to use for the S3 bucket"
  type        = string
  default     = "tf-states-raulmoldes"
  sensitive   = false
}
