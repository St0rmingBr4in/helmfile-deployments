[![Build Status](https://travis-ci.com/St0rmingBr4in/helmfile-deployments.svg?branch=master)](https://travis-ci.com/St0rmingBr4in/helmfile-deployments)

# Deployments of my kubernetes cluster using helmfile

##To test deployment on a test cluster:

```
k3d create --server-arg="--no-deploy=traefik" --publish 8443:443 --publish 8081:80
```
