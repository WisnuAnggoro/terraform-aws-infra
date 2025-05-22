module "route53_zone" {
  source = "./modules/route53/route53-zone"
}

module "s3_bucket" {
  source = "./modules/storage/s3-bucket"
}

module "cloudfront" {
  source = "./modules/cdn/cloudfront"

  wisnuanggoro_com_static_site_bucket                      = module.s3_bucket.wisnuanggoro_com_static_site_bucket
  wisnuanggoro_com_static_site_bucket_id                   = module.s3_bucket.wisnuanggoro_com_static_site_bucket_id
  wisnuanggoro_com_static_site_bucket_arn                  = module.s3_bucket.wisnuanggoro_com_static_site_bucket_arn
  wisnuanggoro_com_static_site_bucket_regional_domain_name = module.s3_bucket.wisnuanggoro_com_static_site_bucket_regional_domain_name
}