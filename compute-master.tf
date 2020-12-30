resource "google_compute_instance" "kube-master" {
  name         = "kube-master"
  machine_type = "n1-standard-2"
  tags         = ["kube-master"]
  # count = "1"

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

  metadata = {
    sshKeys = "Techlivz:${file(var.ssh_public_key_filepath)}"
  }

}

