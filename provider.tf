provider "google" {
  credentials = file("kubenetes-300211-0e972be54a71.json")
  region      = "us-west1"
  zone        = "us-west1-a"
  project     = "kubenetes-300211"
}