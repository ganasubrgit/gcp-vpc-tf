resource "google_compute_instance_template" "default" {
  name        = "es-ins-tpl-ct7-01"
  description = "This template is used to create app server instances."

  tags = ["http-server", "https-server"]

  labels = {
    environment = "dev"
  }

  instance_description = "description assigned to instances"
  machine_type         = "n1-standard-1"
  can_ip_forward       = false

  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
  }

  // Create a new boot disk from an image
  disk {
    source_image = "${var.image}"
    auto_delete  = true
    boot         = true
  }
  network_interface {
    network = "default"
  }
  metadata {
    ssh-keys = "myuser:${file("~/.ssh/gcp_rsa.pub")}"
  }

//----------------------------Startup script---------------------------
  metadata_startup_script = "${file("startup-script.sh")}"
//---------------------------------------------------------------------
  service_account {
    email = "gcpdemo@spherical-plane-230521.iam.gserviceaccount.com"
    scopes = ["cloud-platform"]
  }
}
