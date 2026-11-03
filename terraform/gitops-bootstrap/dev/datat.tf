data "google_container_cluster" "gke" {
  name     = var.cluster_name
  location = var.location
  project  = var.project_id
}

data "google_client_config" "current" {}