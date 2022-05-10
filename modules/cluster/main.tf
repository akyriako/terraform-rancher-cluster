terraform {
  required_providers {
      rancher2 = {
        source = "rancher/rancher2"
	      version = "1.23.0"
      }
  }
}

resource "rancher2_cluster" "cluster_rke" {
  name         = "rke-${var.stack}"
  description  = "rke-${var.stack}"
  rke_config {
    ignore_docker_version = false
    network {
      plugin = "canal"
    }
  }
}
