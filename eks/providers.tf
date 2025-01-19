provider "aws" {
  region = var.aws_region
  
}

terraform {
  required_version = ">= 1.0"
  backend "s3" {
    bucket         = "tf-states-raulmoldes"
    key            = "tf-states/raulmoldes/eks/tf.state"
    region         = "eu-west-1"
    dynamodb_table = "tf_states_raulmoldes"
  }

  required_providers {
    aws = {

      source  = "hashicorp/aws"
      version = "~> 5.49"
    }
  }
}