resource "openstack_networking_secgroup_v2" "backend-sg" {
  name        = "backend-sg"
}

resource "openstack_networking_secgroup_rule_v2" "backend-sg-ssh" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 22
  port_range_max    = 22
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.backend-sg.id}"
}

resource "openstack_networking_secgroup_rule_v2" "backend-sg-iperf" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 5201
  port_range_max    = 5201
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.backend-sg.id}"
}

resource "openstack_networking_secgroup_rule_v2" "backend-sg-http" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 8080
  port_range_max    = 8080
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.backend-sg.id}"
}

resource "openstack_networking_secgroup_rule_v2" "backend-sg-icmp" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "icmp"
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.backend-sg.id}"
}

resource "openstack_compute_instance_v2" "backend-server1" {
  name 			= "backend-server1"
  image_name 		= "Debian 10"
  flavor_name 		= var.flavor
  key_pair 		= "df-keypair"
  security_groups 	= ["${openstack_networking_secgroup_v2.backend-sg.name}"]
  user_data 		= "${file("install-demo-flask.sh")}"

  network {
    name = "${openstack_networking_network_v2.df-network.name}"
  }
  depends_on = [openstack_networking_router_interface_v2.df-router-subnet]
}

resource "openstack_compute_instance_v2" "backend-server2" {
  name 			= "backend-server2"
  image_name 		= "Debian 10"
  flavor_name 		= var.flavor
  key_pair 		= "df-keypair"
  security_groups 	= ["${openstack_networking_secgroup_v2.backend-sg.name}"]
  user_data 		= "${file("install-demo-flask.sh")}"

  network {
    name = "${openstack_networking_network_v2.df-network.name}"
  }
  depends_on = [openstack_networking_router_interface_v2.df-router-subnet]
}
