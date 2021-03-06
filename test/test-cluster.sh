#! /bin/sh

set -x -e

# Get helmfile
curl -fsSL -o /tmp/helmfile https://github.com/roboll/helmfile/releases/download/v0.100.1/helmfile_linux_amd64

sudo install /tmp/helmfile /usr/local/bin/

# Get helm
sudo snap install helm --classic

# Get helm diff plugin
helm plugin install https://github.com/databus23/helm-diff --version master

# Get kubectl
sudo snap install kubectl --classic

# shellcheck source=env
. ./test/env

kubectl apply -R -f raw_k8s

helmfile lint
helmfile apply

retry=5

n=0
until [ $n -ge $retry ]
do
 sleep 15
 helmfile test --args '--logs' && break
 n=$((n + 1))
done
if [ $n -eq $retry ]; then
  echo "helmfile test failed $retry times"
  set +x
  exit 1
fi
