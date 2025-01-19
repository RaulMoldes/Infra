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
