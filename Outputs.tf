

output "s3_website_configuration_domain" {
  value = aws_s3_bucket_website_configuration.sw.website_domain
}

output "s3_website_configuration_endpoint" {
  value = aws_s3_bucket_website_configuration.sw.website_endpoint
}