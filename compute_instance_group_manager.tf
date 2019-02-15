

resource "google_compute_instance_group_manager" "es-igm-01" {
  name = "es-igm-01"
  base_instance_name = "es-inst"
  instance_template  = "${google_compute_instance_template.default.self_link}"
  update_strategy    = "NONE"
  zone               = "${var.zone}"
  target_size  = 1

  # named_port {
  #   name = "customHTTP"
  #   port = 9200
  # }

  # auto_healing_policies {
  #   health_check      = "${google_compute_health_check.autohealing.self_link}"
  #   initial_delay_sec = 300
  # }
}
