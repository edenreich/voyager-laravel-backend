
resource "digitalocean_kubernetes_cluster" "cluster" {
  name    = "${terraform.workspace == "default" ? "staging" : "production"}"
  region  = "${var.do_region}"
  version = "1.14.5-do.0"
  tags    = ["${terraform.workspace == "default" ? "staging" : "production"}"]

  node_pool {
    name       = "${terraform.workspace == "default" ? "staging" : "production"}"
    tags       = ["${terraform.workspace == "default" ? "staging" : "production"}"]
    size       = "s-1vcpu-2gb"
    node_count = "${var.cluster_node_count}"
  }
}

resource "local_file" "kubernetes_config" {
  content  = "${digitalocean_kubernetes_cluster.cluster.kube_config.0.raw_config}"
  filename = "config/${terraform.workspace}-kubeconfig.yaml"
}