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

## Add worker pool to other zones once I know output


resource "ibm_container_worker_pool" "edge_workerpool" {
  resource_group_id = data.ibm_resource_group.rg.id
  worker_pool_name  = "edge"
  machine_type      = "u2c.2x4"
  cluster           = ibm_container_cluster.gw_cluster.id
  size_per_zone     = 2
  hardware          = "shared"
  disk_encryption   = "true"
  region            = var.region

  labels = {
    "dedicated" = "edge"
  }
}

resource "ibm_container_worker_pool_zone_attachment" "edge_zone" {
  cluster         = ibm_container_cluster.gw_cluster.id
  worker_pool     = element(split("/", ibm_container_worker_pool.edge_workerpool.id), 1)
  zone            = var.datacenter
  public_vlan_id  = data.ibm_network_vlan.public.id
  private_vlan_id = data.ibm_network_vlan.private.id
}

