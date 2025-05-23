output "wisnuanggoro_com_distribution_domain_name" {
  value = aws_cloudfront_distribution.wisnuanggoro_com_distribution.domain_name
}

output "wisnuanggoro_com_distribution_hosted_zone_id" {
  value = aws_cloudfront_distribution.wisnuanggoro_com_distribution.hosted_zone_id
}

variable "wisnuanggoro_com_ssl_cert_arn" {
  description = "arn of ssl certificate for wisnuanggoro.com"
  type        = string
}

variable "wisnuanggoro_com_static_site_bucket" {
  description = "bucket for wisnuanggoro.com"
  type        = string
}

variable "wisnuanggoro_com_static_site_bucket_id" {
  description = "bucket id for wisnuanggoro.com"
  type        = string
}

variable "wisnuanggoro_com_static_site_bucket_arn" {
  description = "bucket arn for wisnuanggoro.com"
  type        = string
}

variable "wisnuanggoro_com_static_site_bucket_regional_domain_name" {
  description = "bucket regional domain name for wisnuanggoro.com"
  type        = string
}
