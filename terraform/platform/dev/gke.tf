resource "google_container_cluster" "primary" {
  name     = "gcp-platform-lab-2026-gke-cluster"
  location = var.location
  project  = var.project_id

  network         = google_compute_network.vpc.id
  subnetwork      = google_compute_subnetwork.subnet.id
  networking_mode = "VPC_NATIVE"
  release_channel {
    channel = "REGULAR"
  }

  workload_identity_config {
    workload_pool = "${var.project_id}.svc.id.goog"
  }

  ip_allocation_policy {
    cluster_secondary_range_name  = "gke-pods"
    services_secondary_range_name = "gke-services"
  }

  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = false
  }

  deletion_protection = false

  master_authorized_networks_config {
    dynamic "cidr_blocks" {
      for_each = var.authorized_ips

      content {
        cidr_block   = cidr_blocks.value
        display_name = "authorized-network"
      }
    }

    gcp_public_cidrs_access_enabled = false
  }
}

