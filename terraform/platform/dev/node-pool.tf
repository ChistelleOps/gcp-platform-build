resource "google_container_node_pool" "primary" {
  name       = "gcp-platform-lab-2026-gke-node-pool"
  cluster    = google_container_cluster.primary.id
  node_count = 1

  depends_on = [
    google_project_iam_member.gke_node_role
  ]

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
    service_account = google_service_account.gke_sa.email
  }

}
