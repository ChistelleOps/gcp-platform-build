variable "project_id" {
  description = "The GCP project ID to use for this deployment."
  type        = string
}

variable "region" {
  description = "The GCP region to use for this deployment."
  type        = string
}

variable "location" {
  description = "The GCP location to use for this deployment."
  type        = string
}
variable "authorized_ips" {
  description = "Public IP ranges allowed to access the GKE API"
  type        = list(string)
}