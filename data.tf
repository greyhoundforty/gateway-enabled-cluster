data "ibm_network_vlan" "public" {
  name = "gw-cluster-public"
}

data "ibm_network_vlan" "private" {
  name = "gw-cluster-private"
}

data "ibm_resource_group" "rg" {
  name = var.resource_group
}

