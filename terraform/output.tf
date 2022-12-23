output "frontend-http" {
  value = "${format("http://%s.xip.opensteak.fr", openstack_networking_floatingip_v2.df-fip.address)}"
}
output "frontend-https" {
  value = "${format("https://%s.xip.opensteak.fr", openstack_networking_floatingip_v2.df-fip.address)}"
}
