- name: Write a file in node
  hosts: all
  tasks:
    - name: Create a file here with text "Open Telekom Cloud CCE".
      copy:
        content: "${cluster_node_command} --etcd --controlplane --worker"
        dest: "/tmp/cluster_node_registration_command.txt"
    - name: Register node to the cluster.
      command: ${cluster_node_command} --etcd --controlplane --worker
      