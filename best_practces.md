# Test Your Configurations Locally:
Before applying your Kustomize configurations to a Kubernetes cluster, run kustomize build and review the output locally. This allows you to verify that the customizations are applied correctly and helps prevent errors in production.


#  Configurations DRY (Don't Repeat Yourself):
Avoid duplicating YAML files across environments by using overlays and patches to customize resources as needed. Use features like patchesStrategicMerge or patchesJson6902 to modify only the specific parts of a resource that need to change between environments.


# Directory structure recommendations
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

**kustomization.yaml in dev/ overlay**
bases:
  - ../../base
namePrefix: dev-
patchesStrategicMerge:
  - dev-patch.yaml
