resource "aws_s3_bucket" "wisnuanggoro_com_static_site" {
  bucket        = "wisnuanggoro-com-static-site"
  force_destroy = true
}

resource "aws_s3_bucket_public_access_block" "wisnuanggoro_com_public_access_block" {
  bucket                  = aws_s3_bucket.wisnuanggoro_com_static_site.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}