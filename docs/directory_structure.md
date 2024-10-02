# COMPLEX DIRECTORY STRUCTURE
- base - provides configurations for the applications shared across all environments
- overlays - customizes base configuration
- components - extra features 
- resources - shared resources

my-app/
├── base/
│   ├── deployment.yaml
│   ├── service.yaml
│   ├── kustomization.yaml
├── components/
│   ├── logging/
│   │   ├── logging-config.yaml
│   │   └── kustomization.yaml
│   ├── monitoring/
│   │   ├── prometheus-config.yaml
│   │   └── kustomization.yaml
│   └── debug/
│       ├── debug-config.yaml
│       └── kustomization.yaml
├── overlays/
│   ├── dev/
│   │   ├── kustomization.yaml
│   │   ├── dev-patch.yaml
│   └── staging/
│       ├── kustomization.yaml
│       ├── staging-patch.yaml
│   └── prod/
│       ├── kustomization.yaml
│       ├── prod-patch.yaml
└── resources/
    ├── secrets/
    │   ├── dev-secrets.yaml
    │   ├── staging-secrets.yaml
    │   ├── prod-secrets.yaml
    ├── configmaps/
    │   ├── app-config.yaml
    ├── pvc.yaml
    └── ingress.yaml


## base/ directory:
Contains the common resources that are shared across all environments (e.g., deployment.yaml, service.yaml). 
The kustomization.yaml in this directory should define these common resources.

- base/kustomization.yaml
<!-- resources:
  - deployment.yaml
  - service.yaml

commonLabels:
  app: my-app -->


## components/ directory:
Contains modular, reusable configurations that can be added to any environment as needed. Typically optional featurs like logging, monitoring or debugging.

- components/debug/kustomization.yaml
<!-- resources:
  - debug-config.yaml -->

- components/debug/debug-config.yaml
<!-- apiVersion: v1
kind: ConfigMap
metadata:
  name: debug-config
data:
  log-level: debug -->


## overlays/ directory:
Contains subdirectories for each environment (dev/, staging/, prod/), each with its own kustomization.yaml file that applies environment-specific customizations using patches or transformations.

- overlays/dev/kustomization.yaml
<!-- bases:
  - ../../base

components:
  - ../../components/debug
  - ../../components/logging

resources:
  - ../../resources/secrets/dev-secrets.yaml

patchesStrategicMerge:
  - dev-patch.yaml -->

- overlays/dev/dev-patch.yaml
<!-- apiVersion: apps/v1
kind: Deployment
metadata:
  name: my-app
spec:
  replicas: 1
  template:
    spec:
      containers:
        - name: my-app-container
          resources:
            limits:
              cpu: "500m"
              memory: "512Mi" -->


## resources/ directory:
Contains shared Kubernetes resources like Secrets, ConfigMaps, PVCs, Ingrss definitions which can be reused across multiple environments

- resources/secrets/dev-secrets.yaml
<!-- apiVersion: v1
kind: Secret
metadata:
  name: dev-secret
type: Opaque
data:
  api-key: YmFzZTY0LWVuY29kZWQ= -->
