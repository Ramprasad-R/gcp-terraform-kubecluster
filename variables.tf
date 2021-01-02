variable "ssh_public_key_filepath" {
  description = "Filepath for the ssh public key"
  type        = string
  default     = "gcpkey.pub"
}

variable "worker_count" {
  default = 3
}

variable "GOOGLE_IMAGE" {
  default = "ubuntu-1804-bionic-v20201211a"
}