output "s3_bucket_name" {
  value = aws_s3_bucket.bucket.id
}

output "db_endpoint" {
  value = aws_db_instance.db.address
}
