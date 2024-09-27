# Bases
A base is a collection of Kubernetes manifests that can be reused across multiple environments.

**base/kustomization.yaml**
resources:
  - deployment.yaml
  - service.yaml


# Overlays
Overlays are environment-specific customizations applied to a base. They typically patch or modify the base resources to meet the needs of a specific environment (e.g., adding a different namePrefix or modifying image versions).

**overlays/prod/kustomization.yaml**
bases:
  - ../../base
namePrefix: prod-


# Directory structure
kustomize-project/
├── base/
│   ├── deployment.yaml
│   ├── service.yaml
│   └── kustomization.yaml
├── overlays/
│   ├── dev/
│   │   ├── dev-patch.yaml
│   │   └── kustomization.yaml
│   ├── staging/
│   │   ├── staging-patch.yaml
│   │   └── kustomization.yaml
│   └── prod/
│       ├── prod-patch.yaml
│       └── kustomization.yaml
└── README.md

- base/ directory:
Contains the common resources that are shared across all environments (e.g., deployment.yaml, service.yaml). The kustomization.yaml in this directory should define these common resources.

- overlays/ directory:
Contains subdirectories for each environment (dev/, staging/, prod/), each with its own kustomization.yaml file that applies environment-specific customizations using patches or transformations.