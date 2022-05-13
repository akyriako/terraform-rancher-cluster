- name: Prepare Nodes
  hosts: all
  tasks:
    - name: Copy hard reset script to nodes.
      copy: 
        src: ../../../scripts/reset_nodes.sh
        dest: /tmp/reset_nodes.sh
        follow: yes
        mode: u=rwx,g=rx,o=r
      
- name: Register Nodes
  hosts: all
  tasks:
    - name: Register Nodes to the Cluster.
      command: ${cluster_node_command} --etcd --controlplane --worker
      