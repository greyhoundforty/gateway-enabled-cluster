resource "ibm_container_cluster" "gw_cluster" {
  name                     = "gw-iks-${var.project_name}"
  resource_group_id        = data.ibm_resource_group.rg.id
  datacenter               = var.datacenter
  machine_type             = var.machine_flavor
  hardware                 = var.hardware_type
  gateway_enabled          = true
  public_service_endpoint  = true
  private_service_endpoint = true
  public_vlan_id           = data.ibm_network_vlan.public.id
  private_vlan_id          = data.ibm_network_vlan.private.id
  default_pool_size        = 3
  tags                     = ["schematics-learning", var.project_name]
}

resource "ibm_container_worker_pool" "edge_workerpool" {
  depends_on      = [ibm_container_cluster.gw_cluster]
  cluster         = ibm_container_cluster.gw_cluster.id
  disk_encryption = "true"
  hardware        = "shared"

  labels = {
    "ibm-cloud.kubernetes.io/private-cluster-role" = "worker",
    "node-role.kubernetes.io/edge"                 = "true",
    "dedicated"                                    = "edge"
  }

  machine_type             = "u2c.2x4"
  worker_pool_name         = "edge"
  resource_group_id        = data.ibm_resource_group.rg.id
  size_per_zone            = 2
}

resource "ibm_container_worker_pool_zone_attachment" "edge_zone" {
  depends_on      = [ibm_container_worker_pool.edge_workerpool]
  cluster         = ibm_container_cluster.gw_cluster.id
  worker_pool     = element(split("/", ibm_container_worker_pool.edge_workerpool.id), 1)
  zone            = var.datacenter
  public_vlan_id  = data.ibm_network_vlan.public.id
  private_vlan_id = data.ibm_network_vlan.private.id
}

