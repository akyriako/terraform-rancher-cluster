- name: Register Nodes
  hosts: all
  tasks:
    - name: Register Nodes to the Cluster.
      command: ${cluster_node_command} --etcd --controlplane --worker
      