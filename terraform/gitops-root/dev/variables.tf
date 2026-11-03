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
variable "cluster_name" {
  description = "Existing GKE cluster name"
  type        = string
}