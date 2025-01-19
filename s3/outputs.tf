output "bucket_name" {

  description = "Name of the S3 bucket"
  value       = aws_s3_bucket.tf_states_bucket.bucket

  sensitive = false
}
