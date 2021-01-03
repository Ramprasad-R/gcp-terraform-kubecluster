resource "google_compute_instance" "kube-worker" {
  name         = "kube-worker-${count.index + 1}"
  machine_type = "n1-standard-2"
  tags         = ["kube-worker"]
  count        = var.worker_count

  boot_disk {
    initialize_params {
      image = "ubuntu-1804-bionic-v20201211a"
    }
  }


  network_interface {
    network = "default"

    access_config {
      // Include this section to give the VM an external ip address
    }
  }


  provisioner "file" {
    connection {
      type        = "ssh"
      user        = "ubuntu"
      timeout     = "500s"
      private_key = file("gcpkey")
      agent       = "false"
      host        = self.network_interface[0].access_config[0].nat_ip
    }
    source      = "./scripts/kubeworker.sh"
    destination = "/tmp/kubeworker.sh"
  }
  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = "ubuntu"
      timeout     = "500s"
      private_key = file("gcpkey")
      agent       = "false"
      host        = self.network_interface[0].access_config[0].nat_ip
    }
    inline = [
      "chmod +x /tmp/kubeworker.sh",
      "sh /tmp/kubeworker.sh"
    ]
  }

  # provisioner "local-exec" {
  #   command = "echo ${self.network_interface[0].access_config[0].nat_ip} >> worker-ip"
  # }

  metadata = {
    sshKeys = "ubuntu:${file(var.ssh_public_key_filepath)}"
  }



}