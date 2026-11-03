resource "google_compute_network" "vpc" {
  name                    = "gcp-platform-lab-2026-vpc"
  auto_create_subnetworks = false
}
