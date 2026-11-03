resource "google_compute_subnetwork" "subnet" {
  name                     = "gcp-platform-lab-2026-subnet"
  ip_cidr_range            = "10.100.100.0/26"
  project                  = var.project_id
  region                   = var.region
  network                  = google_compute_network.vpc.id
  private_ip_google_access = true

  secondary_ip_range {
    range_name    = "gke-pods"
    ip_cidr_range = "10.120.96.0/20"
  }

  secondary_ip_range {
    range_name    = "gke-services"
    ip_cidr_range = "10.100.140.0/22"
  }
}
