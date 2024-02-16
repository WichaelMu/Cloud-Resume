# S3 Bucket is defined in main.tf

# resource "aws_s3_object" "index" {
#   bucket       = aws_s3_bucket.b.id
#   key          = "index.html"
#   source       = "Source/index.html"
#   etag         = filemd5("Source/index.html")
#   content_type = "text/html"
# }

# resource "aws_s3_object" "error" {
#   bucket       = aws_s3_bucket.b.id
#   key          = "error.html"
#   source       = "Source/error.html"
#   etag         = filemd5("Source/error.html")
#   content_type = "text/html"
# }

resource "aws_s3_object" "HarryJoh-ezcv-website-recursive" {
  bucket   = aws_s3_bucket.cloud_resume_site_bucket.id
  for_each = fileset("${var.WebsitePath}", "**/*.*")

  key    = each.value
  source = "${var.WebsitePath}${each.value}"

  // Default to binary/octet-stream if no match found in map.
  content_type = lookup(local.MIMETypes, regex("\\.[^.]+$", each.value), "binary/octet-stream")
  etag         = filemd5("${var.WebsitePath}${each.value}")
}

resource "aws_s3_object" "JavaScript" {
  bucket       = aws_s3_bucket.b.id
  key          = "Metrics.js"
  source       = "Source/JavaScript/Metrics.js"
  etag         = filemd5("Source/JavaScript/Metrics.js")
  content_type = "text/javascript"
}