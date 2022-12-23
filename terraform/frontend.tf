data "template_file" "install-nginx" {
  template = "${file("install-nginx.sh.tpl")}"
  vars = {
    frontend = "${openstack_networking_floatingip_v2.df-fip.address}"
    backend  = "${openstack_compute_instance_v2.backend-server1.access_ip_v4}"
  }
}

resource "openstack_networking_secgroup_v2" "frontend-sg" {
  name        = "frontend-sg"
}

resource "openstack_networking_secgroup_rule_v2" "frontend-sg-ssh" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 22
  port_range_max    = 22
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.frontend-sg.id}"
}

resource "openstack_networking_secgroup_rule_v2" "frontend-sg-iperf" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 5201
  port_range_max    = 5201
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.frontend-sg.id}"
}

resource "openstack_networking_secgroup_rule_v2" "frontend-sg-http" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 80
  port_range_max    = 80
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.frontend-sg.id}"
}

resource "openstack_networking_secgroup_rule_v2" "frontend-sg-https" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 443
  port_range_max    = 443
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.frontend-sg.id}"
}

resource "openstack_networking_secgroup_rule_v2" "frontend-sg-icmp" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "icmp"
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.frontend-sg.id}"
}

resource "openstack_compute_instance_v2" "nginx" {
  name             = "nginx"
  image_name       = "Debian 10"
  flavor_name      = var.flavor
  key_pair         = "df-keypair"
  security_groups  = ["${openstack_networking_secgroup_v2.frontend-sg.name}"]
  user_data        = "${data.template_file.install-nginx.rendered}"

  network {
    name = "${openstack_networking_network_v2.df-network.name}"
  }
  depends_on = [openstack_networking_router_interface_v2.df-router-subnet]
}

resource "openstack_compute_floatingip_associate_v2" "frontend-fip" {
  floating_ip = "${openstack_networking_floatingip_v2.df-fip.address}"
  instance_id = "${openstack_compute_instance_v2.nginx.id}"
  depends_on = [openstack_networking_router_interface_v2.df-router-subnet]
}
