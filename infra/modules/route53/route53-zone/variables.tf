output "zone_id" {
  value = aws_route53_zone.wisnuanggoro_com.zone_id
}

output "name_servers" {
  value = aws_route53_zone.wisnuanggoro_com.name_servers
}

output "wisnuanggoro_com_ssl_cert_arn" {
  value = aws_acm_certificate.wisnuanggoro_com_ssl_cert.arn
}

variable "wisnuanggoro_com_distribution_domain_name" {
  description = "domain name for wisnuanggoro.com distribution"
  type        = string
}

variable "wisnuanggoro_com_distribution_hosted_zone_id" {
  description = "hosted zone id for wisnuanggoro.com distribution"
  type        = string
}