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

resource "random_id" "stack" {
  byte_length = 4
}

resource "rancher2_cluster" "cluster_rke" {
  name         = "rke-${random_id.stack.hex}"
  description  = "rke-${random_id.stack.hex}"
  rke_config {
    ignore_docker_version = false
    network {
      plugin = "canal"
    }
  }
}

output "cluster_id" {
  value = rancher2_cluster.cluster_rke.cluster_registration_token.*.cluster_id
}

output "cluster_name" {
  value = rancher2_cluster.cluster_rke.name
}

output "cluster_node_command" {
  value = rancher2_cluster.cluster_rke.cluster_registration_token.*.node_command
}


#resource "rancher2_cluster" "rke_cluster" {
#  name = "dev"
#  description = "terraform rancher2 cluster"
#  rke_config {
#    network {
#      plugin = "canal"
#    }
#  }
#  enable_cluster_monitoring = true
#  cluster_monitoring_input {
#    answers = {
#      "exporter-kubelets.https" = true
#      "exporter-node.enabled" = true
#      "exporter-node.ports.metrics.port" = 9796
#      "exporter-node.resources.limits.cpu" = "200m"
#      "exporter-node.resources.limits.memory" = "200Mi"
#      "grafana.persistence.enabled" = false
#      "grafana.persistence.size" = "10Gi"
#      "grafana.persistence.storageClass" = "default"
#      "operator.resources.limits.memory" = "500Mi"
#      "prometheus.persistence.enabled" = "false"
#      "prometheus.persistence.size" = "50Gi"
#      "prometheus.persistence.storageClass" = "default"
#      "prometheus.persistent.useReleaseName" = "true"
#      "prometheus.resources.core.limits.cpu" = "1000m",
#      "prometheus.resources.core.limits.memory" = "1500Mi"
#      "prometheus.resources.core.requests.cpu" = "750m"
#      "prometheus.resources.core.requests.memory" = "750Mi"
#      "prometheus.retention" = "12h"
#    }
#    version = "0.1.0"
#  }
#}
