
## CREATE DOCKER IMAGE REPOSITORY (Artifact Registry Repository)
resource "google_artifact_registry_repository" "repository" {
  location      = "${var.gcp_region}"
  repository_id = "${var.prefix}"
  description   = "Imagens Docker"
  format        = "DOCKER"
}

# IAM POLICY FOR ARR (Artifact Registry Repository)
resource "google_artifact_registry_repository_iam_binding" "binding" {
  project = google_artifact_registry_repository.repository.project
  location = google_artifact_registry_repository.repository.location
  repository = google_artifact_registry_repository.repository.name
  role = "roles/artifactregistry.reader"
  #members = [ "allAuthenticatedUsers" ]
  members = [ "allUsers" ]
}