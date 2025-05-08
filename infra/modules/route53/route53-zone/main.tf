resource "aws_route53_zone" "anggoro_net" {
  name = "anggoro.net"
}

resource "aws_route53_record" "dev" {
  zone_id = aws_route53_zone.anggoro_net.zone_id
  name    = "dev.anggoro.net"
  type    = "A"
  ttl     = 300
  records = ["192.0.2.123"]
}

resource "aws_route53_record" "staging" {
  zone_id = aws_route53_zone.anggoro_net.zone_id
  name    = "staging.anggoro.net"
  type    = "CNAME"
  ttl     = 300
  records = ["your-other-target.example.com"]
}