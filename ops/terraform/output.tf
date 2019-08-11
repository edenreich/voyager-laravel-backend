
output "cluster_host" {
  description = "The hostname of the kubernetes cluster."
  value       = "${digitalocean_kubernetes_cluster.cluster.kube_config.0.host}"
}