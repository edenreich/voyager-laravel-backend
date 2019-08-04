
provider "kubernetes" {
  version        = "~> 1.8"
  host           = "${module.digitalocean_kubernetes_cluster.cluster_host}"
  config_context = "${terraform.workspace == "default" ? "staging" : "production"}"

  client_certificate     = "${base64decode(module.digitalocean_kubernetes_cluster.cluster_client_certificate)}"
  client_key             = "${base64decode(module.digitalocean_kubernetes_cluster.cluster_client_key)}"
  cluster_ca_certificate = "${base64decode(module.digitalocean_kubernetes_cluster.cluster_ca_certificate)}"
}