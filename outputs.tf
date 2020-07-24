output "worker_pools" {
  value = ibm_container_cluster.gw_cluster.worker_pools
}

output "worker_pool_ids" {
  value = ibm_container_cluster.gw_cluster.worker_pools.id
}
