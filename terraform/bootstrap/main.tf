resource "google_storage_bucket" "terraform_state" {
  # checkov:skip=CKV_GCP_62:Use Cloud Audit Logs for state access auditing instead of legacy GCS usage logging; Data Access audit configuration tracked separately.
  name            = "gcp-platform-lab-2026-terraform-state"
  location        = var.region
  project         = var.project_id
  storage_class   = "STANDARD"
  deletion_policy = "DELETE"
  # Keep everything else unchanged.

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