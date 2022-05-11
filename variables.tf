variable "RANCHER_URL" {
}

variable "RANCHER_ACCESSKEY" {
}

variable "RANCHER_SECRETKEY" {
}

variable cluster_nodes_ips {
   type = list
   default = ["192.168.1.30", "192.168.1.31", "192.168.1.91"]
}

