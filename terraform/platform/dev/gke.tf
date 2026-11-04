resource "google_container_cluster" "primary" {
  # checkov:skip=CKV_GCP_12:GKE Dataplane V2 provides built-in NetworkPolicy enforcement.
  # checkov:skip=CKV_GCP_69:GKE metadata server is enabled in the separately managed node pool.
  # checkov:skip=CKV_GCP_65:Single-user development lab; Google Groups RBAC deferred until multi-team access is implemented.
  # checkov:skip=CKV_GCP_66:Binary Authorization deferred until the container image security pipeline and enforcement policy are implemented.

  # Keep your existing configuration below.
  name                        = "gcp-platform-lab-2026-gke-cluster"
  location                    = var.location
  project                     = var.project_id
  datapath_provider           = "ADVANCED_DATAPATH"
  enable_intranode_visibility = true
  network                     = google_compute_network.vpc.id
  subnetwork                  = google_compute_subnetwork.subnet.id
  networking_mode             = "VPC_NATIVE"
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

  # Disable client certificate authentication
  master_auth {
    client_certificate_config {
      issue_client_certificate = false
    }
  }

  # Identify and organize cluster resources
  resource_labels = {
    environment = "dev"
    project     = "gcp-platform-lab"
    managed_by  = "terraform"
  }
}





