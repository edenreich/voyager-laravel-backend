
resource "digitalocean_volume" "db_data" {
  region                  = "${var.do_region}"
  name                    = "db-data"
  size                    = 20
  initial_filesystem_type = "ext4"
  description             = "A volume to store the database files"
}
