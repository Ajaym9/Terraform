 resource "google_compute_instance" "app-server" {
  name         = var.vm_name
  machine_type = var.machine_type
  zone         = var.zone
  project      = var.project_id


  boot_disk {
    initialize_params {
      image = var.image
      size  = var.disk_size
    }
  }


  network_interface {
    network    = var.network
    subnetwork = var.subnetwork
  }
  tags = var.tags

  service_account {
    email  = var.sa-email
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }

  metadata = {
    startup-script = <<EOF
     #! /bin/bash
    yum update
    yum -y install postgresql
    curl -o cloud-sql-proxy https://storage.googleapis.com/cloud-sql-connectors/cloud-sql-proxy/v2.7.2/cloud-sql-proxy.linux.amd64
    chmod +x cloud-sql-proxy
    EOF
  }
}
