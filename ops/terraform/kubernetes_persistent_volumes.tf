

resource "kubernetes_persistent_volume_claim" "db_data" {
  metadata {
    name = "db-data"
  }
  spec {
    access_modes = ["ReadWriteMany"]
    resources {
      requests = {
        storage = "20Gi"
      }
    }
    volume_name = "${digitalocean_volume.db_data.name}"
  }
}