resource "openstack_networking_network_v2" "df-network" {
  name           = "df-network"
  port_security_enabled = true
}

resource "openstack_networking_subnet_v2" "df-subnet" {
  name       = "df-subnet"
  network_id = "${openstack_networking_network_v2.df-network.id}"
  cidr       = "192.168.199.0/24"
  dns_nameservers = ["1.1.1.1", "8.8.8.8"]
  ip_version = 4
}

data "openstack_networking_network_v2" "public" {
  name = var.public_net
}

resource "openstack_networking_router_v2" "df-router" {
  name                = "df-router"
  external_network_id = data.openstack_networking_network_v2.public.id
}

resource "openstack_networking_router_interface_v2" "df-router-subnet" {
  router_id = "${openstack_networking_router_v2.df-router.id}"
  subnet_id = "${openstack_networking_subnet_v2.df-subnet.id}"
}

resource "openstack_networking_floatingip_v2" "df-fip" {
  pool = var.public_net
}
