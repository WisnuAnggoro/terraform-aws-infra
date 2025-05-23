resource "aws_cloudfront_origin_access_control" "oac" {
  name                              = "s3-oac"
  description                       = "OAC for S3"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

resource "aws_cloudfront_distribution" "wisnuanggoro_com_distribution" {
  enabled             = true
  default_root_object = "index.html"
  is_ipv6_enabled     = true
  wait_for_deployment = true
  aliases             = ["blog.wisnuanggoro.com"]
  # web_acl_id          = <WAF ACL ARN>

  origin {
    domain_name              = var.wisnuanggoro_com_static_site_bucket_regional_domain_name
    origin_id                = var.wisnuanggoro_com_static_site_bucket
    origin_access_control_id = aws_cloudfront_origin_access_control.oac.id
  }

  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD", "OPTIONS"]
    cached_methods         = ["GET", "HEAD", "OPTIONS"]
    target_origin_id       = var.wisnuanggoro_com_static_site_bucket
    viewer_protocol_policy = "redirect-to-https"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn            = var.wisnuanggoro_com_ssl_cert_arn
    ssl_support_method             = "sni-only"
    minimum_protocol_version       = "TLSv1.2_2021"
    cloudfront_default_certificate = false
  }

  tags = {
    Environment = "production"
  }
}

resource "aws_s3_bucket_policy" "allow_cloudfront" {
  bucket = var.wisnuanggoro_com_static_site_bucket_id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AllowCloudFrontServicePrincipal"
        Effect = "Allow"
        Principal = {
          Service = "cloudfront.amazonaws.com"
        }
        Action   = "s3:GetObject"
        Resource = "${var.wisnuanggoro_com_static_site_bucket_arn}/*"
        Condition = {
          StringEquals = {
            "AWS:SourceArn" = aws_cloudfront_distribution.wisnuanggoro_com_distribution.arn
          }
        }
      }
    ]
  })
}