resource "google_container_node_pool" "primary" {
  name       = "gcp-platform-lab-2026-gke-node-pool"
  cluster    = google_container_cluster.primary.id
  node_count = 1

  depends_on = [
    google_project_iam_member.gke_node_role
  ]
  management {
    auto_repair  = true
    auto_upgrade = true
  }
  node_config {
    machine_type = "e2-medium"
    disk_size_gb = 30
    disk_type    = "pd-standard"
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
    metadata = {
      disable-legacy-endpoints = "true"
    }
    workload_metadata_config {
      mode = "GKE_METADATA"
    }
    shielded_instance_config {
      enable_secure_boot          = true
      enable_integrity_monitoring = true
    }
    service_account = google_service_account.gke_sa.email
  }

}
