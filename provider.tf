terraform {
  backend "gcs" {
    bucket = "pgr301-terraform-state"
    prefix = "terraformstate-10013"
    credentials = "terraform.json"
  }
}

provider "google" {
  credentials = "terraform.json"
  project     = "terraform-292215"
  region      = "us-central1"
  zone        = "us-central1-c"
}