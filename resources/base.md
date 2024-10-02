# Bases
A base is a collection of Kubernetes manifests that can be reused across multiple environments.

**base/kustomization.yaml**
resources:
  - deployment.yaml
  - service.yaml

- base/ directory:
Contains the common resources that are shared across all environments (e.g., deployment.yaml, service.yaml). The kustomization.yaml in this directory should define these common resources.
