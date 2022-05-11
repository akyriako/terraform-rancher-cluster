[cluster_nodes]
%{ for cluster_nodes_ip in cluster_nodes_ips ~}
${cluster_nodes_ip}
%{ endfor ~}
