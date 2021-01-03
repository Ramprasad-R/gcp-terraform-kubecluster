resource "google_compute_instance" "kube-master" {
  name         = "kube-master"
  machine_type = "e2-standard-4"
  tags         = ["kube-master"]
  # count = "1"

  boot_disk {
    initialize_params {
      image = var.GOOGLE_IMAGE
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
      type = "ssh"
      user = "ubuntu"
      # timeout     = "500s"
      private_key = file("gcpkey")
      # agent       = "false"
      host = self.network_interface[0].access_config[0].nat_ip
    }
    source      = "./scripts/kubeinstall.sh"
    destination = "/tmp/kubeinstall.sh"
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
      "chmod +x /tmp/kubeinstall.sh",
      "sh /tmp/kubeinstall.sh"
    ]
  }


  # provisioner "local-exec" {
  #   command = "gcloud compute scp kube-master:/tmp/temp.txt ."
  # }


  metadata = {
    sshKeys = "ubuntu:${file(var.ssh_public_key_filepath)}"
  }

}

