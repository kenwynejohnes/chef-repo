resource "google_container_cluster" "primary" {
  name     = "my-gke-cluster"
  location = "us-central1"
  master_auth {
    username = "user"
    password = "password"

    client_certificate_config {
      issue_client_certificate = true
    }
  }
  addons_config {
  kubernetes_dashboard {
    disabled = false
  }
  http_load_balancing {
    disabled = true
  }
  }
  enable_legacy_abac = true
}

resource "google_container_node_pool" "primary_preemptible_nodes" {
  name     = "my-gke-cluster"
  location = "us-central1"
  node_config {
    preemptible  = true
    machine_type = "n1-standard-1"
    image_type = "anytype"
  }
}

resource "google_compute_subnetwork" "network-with-private-secondary-ip-ranges" {
  name                     = "test-subnetwork"
  ip_cidr_range            = "10.3.0.0/16"
  region                   = "us-east1"
  network                  = "${google_compute_network.custom-test.self_link}"
  private_ip_google_access = "true"
}

resource "google_compute_instance_template" "default" {
  name        = "appserver-template"
  description = "This template is used to create app server instances."
  can_ip_forward       = true
}

 resource "google_project" "my_project" {
  name       = "My Project"
  project_id = "your-project-id"
  org_id     = "1234567"
}

resource "google_compute_project_metadata_item" "default" {
  key   = "enable-oslogin"
  value = false
}

resource "google_service_account_key" "mykey" {
  service_account_id = "myaccount.name.iam.gserviceaccount.com"
  public_key_type    = "TYPE_X509_PEM_FILE"
}

resource "google_compute_disk" "default" {
  name  = "test-disk"
  type  = "pd-ssd"
  zone  = "us-central1-a"
  image = "debian-8-jessie-v20170523"
  disk_encryption_key = "somevalue"
}

resource "google_sql_database_instance" "master" {
  name             = "master-instance-${random_id.db_name_suffix.hex}"
  database_version = "MYSQL_5_7"
}

resource "google_organization_iam_binding" "binding" {
  org_id = "123456789"
  role    = "roles/iam.serviceAccountActor"

  members = [
    "user:alice@gmail.com",
  ]
}

resource "google_organization_iam_member" "binding" {
  org_id = "0123456789"
  role   = "roles/cloudkms.admin"
  member = "user:alice@gmail.com"
}

resource "google_organization_iam_binding" "binding" {
  org_id = "123456789"
  role    = "roles/editor"

  members = [
    "user:alice.gserviceaccount.com",
  ]
}

resource "google_storage_bucket_access_control" "public_rule" {
  bucket = "google_storage_bucket.bucket.name"
  role   = "READER"
  entity = "allUsers"
}

resource "google_storage_bucket" "image-store" {
  name     = "image-store-bucket"
  location = "EU"
  versioning {
      enabled = false
  }
}
