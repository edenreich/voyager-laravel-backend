resource "kubernetes_deployment" "backend" {
  metadata {
    name = "backend-app-deployment"
    
    labels = {
      app = "backend"
    }
  }

  spec {
    replicas = "${var.deployment_app_replicas_count}"

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

resource "kubernetes_deployment" "mysql" {
  metadata {
    name = "backend-mysql-deployment"
    labels = {
      app = "backend-mysql-deployment"
    }
  }

  spec {
    replicas = "${var.deployment_database_replicas_count}"

    selector {
      match_labels = {
        app = "backend-database"
      }
    }

    template {
      metadata {
        labels = {
          app = "backend-database"
        }
      }

      spec {
        container {
          image = "mysql:5.7.27"
          name  = "mysql"

          env {
            name = "MYSQL_ROOT_PASSWORD"
            value_from {
              secret_key_ref {
                name = "${kubernetes_secret.mysql.metadata.0.name}"
                key  = "password"
              }
            }
          }

          port {
            container_port = 3306
            name           = "mysql"
          }

          volume_mount {
            name       = "${kubernetes_persistent_volume_claim.db_data.metadata.0.name}"
            mount_path = "/var/lib/mysql"
          }
        }

        volume {
          name = "${kubernetes_persistent_volume_claim.db_data.metadata.0.name}"
          persistent_volume_claim {
            claim_name = "${kubernetes_persistent_volume_claim.db_data.metadata.0.name}"
          }
        }
      }
    }
  }
}
