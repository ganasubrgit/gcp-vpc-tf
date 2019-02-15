resource "google_storage_bucket" "img-es-auto" {
  name     = "img-es-auto"
  location = "US"
  force_destroy = true
}