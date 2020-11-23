terraform {
  backend "gcs" {
    bucket = "mybucket1pgr301"
    prefix = "terraformstate"
    credentials = "exam1pg301.json"
  }
}

provider "google-beta" {
  credentials = file("exam1pg301.json")
  project     = "exam1pg301"
  version = "~> 3.0.0-beta.1"
}