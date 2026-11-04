resource "google_compute_network" "vpc" {
  # checkov:skip=CKV2_GCP_18:GKE manages required cluster firewall rules; no additional custom ingress rules are needed for this lab.
  name                    = "gcp-platform-lab-2026-vpc"
  auto_create_subnetworks = false
}
