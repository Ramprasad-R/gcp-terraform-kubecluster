# # Specify the provider (GCP, AWS, Azure)
# provider "google" {
# credentials = file("kubenetes-300211-0e972be54a71.json")
# project = "kubernetes"
# region = "eu-west-3"
# }

# #
# resource "google_compute_firewall" "shi-rvs-firewall-externalssh" {
#   name    = "shi-rvs-firewall-externalssh"
#   network = "default"

#   allow {
#     protocol = "tcp"
#     ports    = ["22"]
#   }

#   source_ranges = ["0.0.0.0/0"]
#   target_tags   = ["externalssh"]
# }
# #
# resource "google_compute_instance" "master" {
#   name         = "master"
#   machine_type = "e2-standard-4"
#   zone         = "europe-west3-c"
#   count        = "1"

#   boot_disk {
#     initialize_params {
#       image = "ubuntu-1804-bionic-v20201211a"
#     }
#   }

#   network_interface {
#     network = "default"

#     access_config {
#       // Include this section to give the VM an external ip address
#     }
#   }
# #  metadata {
# #    sshKeys = "(Techlivz):${file("gcpkey")}"
# #  }

#   provisioner "remote-exec" {
#     connection {
#       type        = "ssh"
#       user        = "Techlivz"
#       timeout     = "500s"
#       private_key = file("gcpkey")
#           agent           = "false"
#     }

#     inline = [
#       "touch /tmp/temp.txt",
#     ]
#   }

#   provisioner "file" {
#       connection {
#       type        = "ssh"
#       user        = "Techlivz"
#       timeout     = "500s"
#       private_key = file("gcpkey")
#           agent           = "false"
#     }
#     source      = "./scripts"
#     destination = "/tmp/"
#   }
#   provisioner "remote-exec" {
#       connection {
#       type        = "ssh"
#       user        = "Techlivz"
#       timeout     = "500s"
#       private_key = file("gcpkey")
#           agent           = "false"
#     }
#     inline = [
#       "chmod +x /tmp/scripts/*.sh",
#       "sudo sh /tmp/scripts/docker_install.sh",
#       "sudo sh /tmp/scripts/kubeadm.sh"
#       ]
#   }

# depends_on = ["google_compute_firewall.shi-rvs-firewall-externalssh"]
#     // Apply the firewall rule to allow external IPs to access this instance
#     tags = ["http-server"]
#   metadata {
#     ssh-keys = "Techlivz:${file("gcpkey.pub")}"
#         }
# }
# #
# resource "google_compute_firewall" "http-server" {
#   name    = "default-allow-http-terraform"
#   network = "default"

#   allow {
#     protocol = "tcp"
#     ports    = ["80"]
#   }

#   // Allow traffic from everywhere to instances with an http-server tag
#   source_ranges = ["0.0.0.0/0"]
#   target_tags   = ["http-server"]
# }

# output "ip" {
#   value = "${google_compute_instance.master.network_interface.0.access_config.0.nat_ip}"
# }