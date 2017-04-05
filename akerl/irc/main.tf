resource "google_compute_instance" "irc" {
  name         = "irc"
  machine_type = "f1-micro"
  zone         = "us-central1-a"

  disk {
    image = "ubuntu-1604-lts"
  }

  disk {
    disk = "${google_compute_disk.irc.name}"
  }

  network_interface {
    network = "default"

    access_config {
      nat_ip = "${google_compute_address.irc.address}"
    }
  }
}

resource "google_compute_disk" "irc" {
  name  = "irc-data"
  type  = "pd-standard"
  zone  = "us-central1-a"
  size = 5
}

resource "google_compute_address" "irc" {
  name = "irc"
  region = "us-central1"
}
