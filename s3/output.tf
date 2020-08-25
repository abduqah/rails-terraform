#----s3/output.tf----

output "bucket_domain_name" {
  value = aws_s3_bucket.tf_s3.bucket_domain_name
}