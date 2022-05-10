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



