
provider "digitalocean" {
  version = "1.5.0"
  token   = "${var.do_access_token}"
}

provider "kubernetes" {
  version        = "~> 1.8"
  host           = "${digitalocean_kubernetes_cluster.cluster.kube_config.0.host}"
  config_context = "${terraform.workspace == "default" ? "staging" : "production"}"

  client_certificate     = "${base64decode(digitalocean_kubernetes_cluster.cluster.kube_config.0.client_certificate)}"
  client_key             = "${base64decode(digitalocean_kubernetes_cluster.cluster.kube_config.0.client_key)}"
  cluster_ca_certificate = "${base64decode(digitalocean_kubernetes_cluster.cluster.kube_config.0.cluster_ca_certificate)}"
}