module "route53" {
  source = "./modules/route53/route53-zone"
}

module "storage" {
  source = "./modules/storage/s3-bucket"
}
