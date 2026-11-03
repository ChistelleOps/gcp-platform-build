terraform {
  required_version = ">= 1.16.0, < 2.0.0"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 8.9"
    }
  }
  backend "gcs" {
    bucket = "gcp-platform-lab-2026-terraform-state"
    prefix = "platform/dev"
  }

}