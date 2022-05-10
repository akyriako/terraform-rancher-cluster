output "cluster_id" {
  value = rancher2_cluster.cluster_rke.cluster_registration_token.*.cluster_id
}

output "cluster_name" {
  value = rancher2_cluster.cluster_rke.name
}

output "cluster_node_command" {
  value = rancher2_cluster.cluster_rke.cluster_registration_token.*.node_command
}
