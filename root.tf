terraform {
  required_version = ">= 0.12.0"
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

module "cluster" {
   source = "./modules/cluster"
   providers = {
           rancher2 = rancher2
        }
   stack = "${random_id.stack.hex}"
}

module "nodes" {
   source = "./modules/nodes"
   providers = {
           rancher2 = rancher2
        }
   stack = "${random_id.stack.hex}"
   cluster_nodes_ips = var.cluster_nodes_ips
   cluster_node_command = module.cluster.cluster_node_command
   remote_sudoer = var.remote_sudoer
   private_key_file = var.private_key_file
   wait_for = [ module.cluster.cluster_name ]
}




