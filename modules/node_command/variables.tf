variable "cluster_nodes_ips" {
   type = list
}

variable "stack" {
   description = "Stack unique ID"
}

variable "cluster_node_command" {
   description = "Cluster Registration Command"
}

variable "wait_for" {
  type    = any
  default = []
}




