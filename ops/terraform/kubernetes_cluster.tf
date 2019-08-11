
module "digitalocean_kubernetes_cluster" {
  source             = "github.com/edenreich/terraform-digitalocean-kubernetes-cluster"
  do_token           = "${var.do_access_token}"
  do_region          = "fra1"
  cluster_name       = "${terraform.workspace == "default" ? "staging" : "production"}"
  cluster_pool_name  = "${terraform.workspace == "default" ? "staging" : "production"}"
  cluster_node_size  = "s-1vcpu-2gb"
  cluster_node_count = "${var.cluster_node_count}"
  cluster_tags       = ["${terraform.workspace == "default" ? "staging" : "production"}"]
  cluster_node_tags  = ["${terraform.workspace == "default" ? "staging" : "production"}"]
}

resource "local_file" "kubernetes_config" {
  content  = "${module.digitalocean_kubernetes_cluster.cluster_raw_config}"
  filename = "config/${terraform.workspace}-kubeconfig.yaml"
}