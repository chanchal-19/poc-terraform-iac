output "instance_name" {
  value = google_compute_instance.training_demo.name
}

output "disk_name" {
  value = google_compute_disk.default.name
}

output "public_address" {
  value = google_compute_address.static.address
}
