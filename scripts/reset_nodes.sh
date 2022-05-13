#!/bin/bash
echo "Manually resetting Rancher Nodes"
echo "5sec window to cancel with CTRL-C"
echo
sleep 5

echo "Removing docker containers > "

containers=$(docker ps -a | grep -E "rancher|k8s" | awk '{print $1}')

if [ "${containers}x" != "x" ]
then
  docker rm -f $containers
else
  echo "No containers found..."
fi

echo "Removing docker images > "

images=$(docker images -a | grep -E "rancher|k8s" | awk '{print $3}')

if [ "${images}x" != "x" ]
then
  docker rmi $images
else
  echo "No images found..."
fi

echo "Removing docker images > "

docker volume prune -f

echo "Removing directories > "

directories="/var/lib/etcd /etc/kubernetes /etc/cni /opt/cni /var/lib/cni /var/lib/calico /var/lib/etcd /var/lib/rancher/* /var/run/calico /opt/rke"

for directory in $directories; do
  echo "Removing $directory"
  rm -rf $directory
done