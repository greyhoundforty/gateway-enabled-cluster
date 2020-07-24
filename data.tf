data "ibm_network_vlan" "public" {
    name = "gw-cluster-public"
}

data "ibm_network_vlan" "private" {
    name = "gw-cluster-private"
}


