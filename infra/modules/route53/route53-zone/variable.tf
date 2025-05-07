output "zone_id" {
  value = aws_route53_zone.anggoro_net.zone_id
}

output "name_servers" {
  value = aws_route53_zone.anggoro_net.name_servers
}