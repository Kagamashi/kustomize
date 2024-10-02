#!/bin/bash

# This command builds the configuration from the specified directory
# which contains the kustomization.yaml file.
kustomize build ./overlays/dev

# You can pipe the output to kubectl to apply it to the cluster.
kustomize build ./overlays/dev | kubectl apply -f -
