
resource "kubernetes_secret" "docker_config" {
  metadata {
    name = "docker-config"
  }

  data = {
    ".dockerconfigjson" = "${file("~/.docker/config.json")}"
  }

  type = "kubernetes.io/dockerconfigjson"
}