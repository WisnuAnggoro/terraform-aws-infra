# Create public hosted zone
resource "aws_route53_zone" "wisnuanggoro_com" {
  name = "wisnuanggoro.com"
}

# Request the ACM Certificate
resource "aws_acm_certificate" "wisnuanggoro_com_ssl_cert" {
  domain_name       = "*.${aws_route53_zone.wisnuanggoro_com.name}"
  validation_method = "DNS"

  tags = {
    Environment = "production"
  }

  lifecycle {
    create_before_destroy = true
  }
}

# Get the DNS Validation Record from ACM
resource "aws_route53_record" "cert_validation" {
  for_each = {
    for dvo in aws_acm_certificate.wisnuanggoro_com_ssl_cert.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      type   = dvo.resource_record_type
      record = dvo.resource_record_value
    }
  }

  zone_id = aws_route53_zone.wisnuanggoro_com.zone_id
  name    = each.value.name
  type    = each.value.type
  ttl     = 60
  records = [each.value.record]
}

# Certificate Validation Resource
resource "aws_acm_certificate_validation" "cert_validation" {
  certificate_arn         = aws_acm_certificate.wisnuanggoro_com_ssl_cert.arn
  validation_record_fqdns = [for record in aws_route53_record.cert_validation : record.fqdn]
}