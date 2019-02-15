// Configure the Google Cloud provider
provider "google" {
 credentials = "${file("${var.credentials}")}"
 project     = "${var.project_name}" 
 region      = "${var.region}"
 zone         = "${var.zone}"
}

// Create VPC
resource "google_compute_network" "vpc" {
 name                    = "${var.name}-vpc"
 auto_create_subnetworks = "false"
 project                 = "${var.project_name}"
}

// Create Subnet
resource "google_compute_subnetwork" "subnet" {
 name          = "${var.name}-vpc"
 ip_cidr_range = "${var.subnet_cidr}"
 network       = "${var.name}-vpc"
 depends_on    = ["google_compute_network.vpc"]
 region      = "${var.region}"
}

// VPC firewall configuration
resource "google_compute_firewall" "firewall" {
  name    = "${var.name}-firewall"
  network = "${google_compute_network.vpc.name}"
  
  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["22", "80"]
  }
  source_ranges = ["0.0.0.0/0"]
}

// VM instance configuration
# resource "google_compute_instance" "vm-ins-01" {
#   name         = "instance-${count.index}"
#   machine_type = "${var.machine_type}"
#   depends_on    = ["google_compute_subnetwork.subnet"]

#   boot_disk {
#     initialize_params {
#       image = "${var.image}"
#     }
#   }

#   network_interface {
#     subnetwork = "${google_compute_network.vpc.name}"
#     access_config {}
#   }
# //----------------------------Startup script---------------------------
#   metadata_startup_script = "${file("startup-script.sh")}"
# //---------------------------------------------------------------------
# allow_stopping_for_update = true
# count = "${var.node_count}"
# }


