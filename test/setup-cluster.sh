#! /bin/sh

set -x -e

# Get k3d
curl -s https://raw.githubusercontent.com/rancher/k3d/master/install.sh | bash

k3d create --server-arg="--no-deploy=traefik" --publish 8443:443 --publish 8081:80

set +e

while [ -z "$KUBECONFIG" ]; do
  KUBECONFIG="$(k3d get-kubeconfig --name='k3s-default')"
  sleep 1
done

export KUBECONFIG
