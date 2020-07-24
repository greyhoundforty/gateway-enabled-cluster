resource "ibm_container_cluster" "gw_cluster" {
  name            = "gw-iks-${var.project_name}"
  datacenter      = var.datacenter
  machine_type    = var.machine_flavor
  hardware        = var.hardware_type
  gateway_enabled = true 
  public_service_endpoint = true 
  private_service_endpoint = true 
  public_vlan_id = data.ibm_network_vlan.public.id
  private_vlan_id = data.ibm_network_vlan.private.id 
  default_pool_size      = 3
  tags = ["schematics-learning", var.project_name]

  webhook = [{
    level = "Normal"
    type = "slack"
    url = "https://hooks.slack.com/services/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"
  }
 ]
}

## Add worker pool to other zones once I know output
