#!/bin/bash

# List the resources and their status in the directory containing kustomization.yaml.
kustomize cfg list ./overlays/dev

# Format all Kubernetes manifests in the directory.
kustomize cfg fmt ./overlays/dev
