output "master-ip" {
  value = google_compute_instance.kube-master.network_interface.0.access_config.0.nat_ip
}

output "worker-ip" {
  value = google_compute_instance.kube-worker[*].network_interface.0.access_config.0.nat_ip
}


# output "worker-ip" {
#   value = {
#     for instance in google_compute_instance.kube-worker :
#     instance.name => instance.network_interface.0.access_config.0.nat_ip
#   }
# }