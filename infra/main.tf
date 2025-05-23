module "route53_zone" {
  source = "./modules/route53/route53-zone"

  providers = {
    aws           = aws
    aws.us_east_1 = aws.us_east_1
  }

  wisnuanggoro_com_distribution_domain_name    = module.cloudfront.wisnuanggoro_com_distribution_domain_name
  wisnuanggoro_com_distribution_hosted_zone_id = module.cloudfront.wisnuanggoro_com_distribution_hosted_zone_id
}

module "s3_bucket" {
  source = "./modules/storage/s3-bucket"
}

module "cloudfront" {
  source = "./modules/cdn/cloudfront"

  wisnuanggoro_com_ssl_cert_arn = module.route53_zone.wisnuanggoro_com_ssl_cert_arn

  wisnuanggoro_com_static_site_bucket                      = module.s3_bucket.wisnuanggoro_com_static_site_bucket
  wisnuanggoro_com_static_site_bucket_id                   = module.s3_bucket.wisnuanggoro_com_static_site_bucket_id
  wisnuanggoro_com_static_site_bucket_arn                  = module.s3_bucket.wisnuanggoro_com_static_site_bucket_arn
  wisnuanggoro_com_static_site_bucket_regional_domain_name = module.s3_bucket.wisnuanggoro_com_static_site_bucket_regional_domain_name
}