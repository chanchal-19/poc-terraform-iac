variable "gcp_project_id" {
  description = "This is a GCP Project id"
  default = "trim-attic-318304"
  type        = string
}

variable "gcp_project_location" {
  description = "This is a GCP Project id"
  default = "us-west2"
  type        = string
}

variable "machine_type" {
  description = "This is the type of the machine"
  default = "f1-micro"
  type        = string
}

variable "gcp_compute_zone" {
  description = "This is the zone in which the compute instances will be created"
  default = "us-west1-a"
  type        = string
}