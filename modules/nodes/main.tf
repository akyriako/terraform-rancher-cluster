terraform {
  required_providers {
      rancher2 = {
        source = "rancher/rancher2"
	      version = "1.23.0"
      }
  }
}

resource "local_file" "ansible_inventory" {
  depends_on = [
    var.wait_for
  ]

  content     = templatefile("${path.module}/ansible/templates/inventory.tpl", 
    { 
      cluster_nodes_ips = var.cluster_nodes_ips
    })
  filename    = "${path.module}/ansible/inventory"
}

resource "local_file" "ansible_config" {
  
  content     = templatefile("${path.module}/ansible/templates/ansible.tpl", 
    { 
      remote_sudoer = var.remote_sudoer
      private_key_file = var.private_key_file
    })
  filename    = "${path.module}/ansible/ansible.cfg"
}

resource "local_file" "ansible_playbook" {

  content     = templatefile("${path.module}/ansible/templates/playbook.tpl", 
    { 
      cluster_node_command = var.cluster_node_command[0]
    })
  filename    = "${path.module}/ansible/playbook.yml"

  provisioner "local-exec" {
    working_dir = "${path.module}/ansible"
    command     = "ansible-playbook -i inventory playbook.yml"
  }

}
