resource "kubernetes_deployment" "backend" {
  metadata {
    name = "backend-deployment"
    
    labels = {
      app = "backend"
    }
  }

  spec {
    replicas = "${var.deployment_replicas_count}"

    selector {
      match_labels = {
        app = "backend"
      }
    }

    template {
      metadata {
        labels = {
          app = "backend"
        }
      }

      spec {
        image_pull_secrets {
          name = "${kubernetes_secret.docker_config.metadata.0.name}"
        }

        container {
          image = "${var.backend_pod_image}"
          name  = "${var.backend_pod_name}"

          port {
            container_port = 80
          }

          resources {
            limits {
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests {
              cpu    = "250m"
              memory = "50Mi"
            }
          }
        }
      }
    }
  }
}