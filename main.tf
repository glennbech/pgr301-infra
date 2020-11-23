resource "google_cloud_run_service" "hello" {
  name = "cloudrun-srv"
  location = "us-central1"
  project = "exam1pg301"

  template {
    spec {
      containers {
        image = "gcr.io/exam1pg301/exam1image@sha256:df3cfdccbdd5d6068a1a9da9ec49eea73987685aea070ac8e8466cc6270fd7a2"
        env {
            name = "LOGZ_TOKEN"
            value = var.logz_token
        }
        env {
            name = "LOGZ_URL"
            value = var.logz_url
        }
        resources {
            limits = {
                memory: 512
            }
        }
      }
    }
  }



  traffic {
    percent = 100
    latest_revision = true
  }
}


data "google_iam_policy" "noauth" {
  binding {
    role = "roles/run.invoker"
    members = [
      "allUsers",
    ]
  }
}

resource "google_cloud_run_service_iam_policy" "noauth" {
  location    = google_cloud_run_service.hello.location
  project     = google_cloud_run_service.hello.project
  service     = google_cloud_run_service.hello.name
  policy_data = data.google_iam_policy.noauth.policy_data
}