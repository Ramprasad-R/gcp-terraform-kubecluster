resource "google_compute_firewall" "shi-rvs-firewall-externalssh" {
  name    = "shi-rvs-firewall-externalssh"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["externalssh"]
}