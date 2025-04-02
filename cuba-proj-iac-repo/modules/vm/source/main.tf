 resource "google_compute_instance" "vm-server" {
  name         = var.vm_name
  machine_type = var.machine_type
  zone         = var.zone
  project      = var.project_id


  boot_disk {
    initialize_params {
      image = var.image
      type  = var.disk_type
      size  = var.disk_size
    }
  } 
  

  network_interface {
    network    = var.network
    subnetwork = var.subnetwork
    network_ip = var.network_ip
  }
  
  tags = var.tags

  service_account {
    email  = var.sa-email
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }

  metadata = {
    hostname = var.hostname
  }

 }



