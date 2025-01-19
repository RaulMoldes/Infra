provider "aws" {
  region = var.aws_region
}


resource "aws_s3_bucket" "tf_states_bucket" {
  bucket = "tf-states-raulmoldes"


  lifecycle {
    prevent_destroy = true ## TRYING TO DELETE WILL CAUSE AN ERROR
    ## NECESSARY TO AVOID ACCIDENTAL DELETION
  }

  tags = {
    Name        = "tf-states-raulmoldes"
    CreatedBy   = "raul.moldes.work@gmail.com"
    Description = "Bucket used to store Terraform state files."
  }



}

resource "aws_s3_bucket_server_side_encryption_configuration" "tf_states_bucket_sse" {
  bucket = aws_s3_bucket.tf_states_bucket.bucket
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "tf_states_public_access_lock" {
  bucket                  = aws_s3_bucket.tf_states_bucket.bucket
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_versioning" "tf_states_bucket_versioning" {
  bucket = aws_s3_bucket.tf_states_bucket.bucket
  versioning_configuration {
    status = "Enabled"
  }
}
