terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.38.0"
    }
  }
}

provider "google" {
 project     = "managed-inventory"
  region      = "us-central1"
  zone        = "us-central1-a"
}


# resource "google_compute_firewall" "default" {
#   name    = "loveth-firewall"
#   network = google_compute_network.default.name

#   allow {
#     protocol = "icmp"
#   }

#   allow {
#     protocol = "tcp"
#     ports    = ["80", "8080", "1000-2000", "22"]
#   }

#   target_tags = ["web"]
# }

# resource "google_compute_network" "default" {
#   name = "test-network"
# }

# resource "google_service_account" "default" {
#   account_id   = "loveth-test-sa"
#   display_name = "loveth-test-sa"
# }

# resource "google_compute_instance" "default" {
#   name         = "test-server"
#   machine_type = "e2-medium"
#   zone         = "us-central1-a"

#   tags = ["web"] 

#   boot_disk {
#     initialize_params {
#       image = "centos-cloud/centos-7"
#     }
#   }

#   // Local SSD disk
# #   scratch_disk {
# #     interface = "SCSI"
# #   }

#   network_interface {
#     network = "default"

#     access_config {
#       // Ephemeral public IP
#     }
#   }

#  metadata = {
#     enable-oslogin: "TRUE"
#   }


#   service_account {
#     # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
#     email  = google_service_account.default.email
#     scopes = ["cloud-platform"]
#   }
# }


resource "google_service_account" "default" {
  account_id   = "service-account-id"
  display_name = "Service Account"
}

resource "google_container_cluster" "primary" {
  name               = "test-cluster"
  location           = "us-central1-a"
  initial_node_count = 3
  node_config {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    service_account = google_service_account.default.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
    labels = {
      foo = "bar"
    }
    tags = ["foo", "bar"]
  }
  timeouts {
    create = "30m"
    update = "40m"
  }
}