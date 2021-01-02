output "master-ip" {
  value = google_compute_instance.kube-master.network_interface.0.access_config.0.nat_ip
}

output "worker-ip" {
  value = google_compute_instance.kube-worker[*].network_interface.0.access_config.0.nat_ip
}

# output "instance_ip_addresses" {
#   # Result is a map from instance id to private and public IP addresses, such as:
#   #  {"i-1234" = ["192.168.1.2","54.234.188.251,] "i-5678" = ["192.168.1.5","3.90.189.190",] }
#   value = {
#     for instance in aws_instance.server:
#       instance.id => instance.private_ip
#   }
# }


# output "worker-ip" {
#   value = {
#     for instance in google_compute_instance.kube-worker :
#     instance.name => instance.network_interface.0.access_config.0.nat_ip
#   }
# }