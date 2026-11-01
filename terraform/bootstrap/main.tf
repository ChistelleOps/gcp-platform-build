resource "google_storage_bucket" "terraform_state" {
  name            = "gcp-platform-lab-2026-terraform-state"
  location        = var.region
  project         = var.project_id
  storage_class   = "STANDARD"
  deletion_policy = "DELETE"

  public_access_prevention    = "enforced"
  uniform_bucket_level_access = true

  # Enable Object Versioning
  versioning {
    enabled = true
  }
  soft_delete_policy {
    retention_duration_seconds = 604800
  }

  lifecycle {
    prevent_destroy = true
  }
}