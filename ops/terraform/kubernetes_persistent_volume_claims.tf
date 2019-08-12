

resource "kubernetes_persistent_volume_claim" "db_data" {
  metadata {
    name = "db-data"
  }

  spec {
    access_modes = ["ReadWriteOnce"]

    resources {
      requests = {
        storage = "15Gi"
      }
    }

    storage_class_name = "do-block-storage"
  }
}