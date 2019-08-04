
resource "kubernetes_service" "backend" {
  metadata {
    name      = "${var.backend_service_name}"
    namespace = "default"
  }

  spec {
      selector = {
        app = "${kubernetes_deployment.backend.metadata.0.labels.app}"
      }

      port {
        port        = 80
        target_port = 80
        node_port   = 30000
      }

      type = "NodePort"
  }
}
