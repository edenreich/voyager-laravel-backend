

resource "kubernetes_persistent_volume_claim" "db_data" {
  metadata {
    name = "db-data"
    namespace = "default"
  }

  spec {
    access_modes = ["ReadWriteMany"]

    resources {
      requests = {
        storage = "${digitalocean_volume.db_data.size}Gi"
      }
    }

    volume_name = "${digitalocean_volume.db_data.name}"
    storage_class_name = "do-block-storage"
  }
}