variable "ssh_public_key_filepath" {
  description = "Filepath for the ssh public key"
  type        = string
  default     = "gcpkey.pub"
}

variable "worker_count" {
  default = 3
}