terraform {
  required_version = ">= 0.12.0"
  #backend "s3" { }
  required_providers {
      rancher2 = {
         source = "rancher/rancher2"
	 version = "1.23.0"
      }
  }
}

#provider "rancher2" {
#  api_url    = var.RANCHER_URL
#  access_key = var.RANCHER_ACCESSKEY
#  secret_key = var.RANCHER_SECRETKEY
#}

#provider "rancher2" {
#  api_url    = var.RANCHER_URL
#  bootstrap = true
#}

#provider "rancher2" {
#  alias = "bootstrap"

#  api_url    = var.RANCHER_URL
#  bootstrap = true
#}

resource "random_id" "stack" {
  byte_length = 4
}

resource "rancher2_cluster" "rke_cluster" {
  name = "dev"
  description = "terraform rancher2 cluster"
  rke_config {
    network {
      plugin = "canal"
    }
  }
  enable_cluster_monitoring = true
  cluster_monitoring_input {
    answers = {
      "exporter-kubelets.https" = true
      "exporter-node.enabled" = true
      "exporter-node.ports.metrics.port" = 9796
      "exporter-node.resources.limits.cpu" = "200m"
      "exporter-node.resources.limits.memory" = "200Mi"
      "grafana.persistence.enabled" = false
      "grafana.persistence.size" = "10Gi"
      "grafana.persistence.storageClass" = "default"
      "operator.resources.limits.memory" = "500Mi"
      "prometheus.persistence.enabled" = "false"
      "prometheus.persistence.size" = "50Gi"
      "prometheus.persistence.storageClass" = "default"
      "prometheus.persistent.useReleaseName" = "true"
      "prometheus.resources.core.limits.cpu" = "1000m",
      "prometheus.resources.core.limits.memory" = "1500Mi"
      "prometheus.resources.core.requests.cpu" = "750m"
      "prometheus.resources.core.requests.memory" = "750Mi"
      "prometheus.retention" = "12h"
    }
    version = "0.1.0"
  }
}
