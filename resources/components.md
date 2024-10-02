# Components
'MODULES'' : Handy when dealing with applications that support multiple optional features and we want to enable only a subset of them in different overlays

- Multiple components can extend and transform the same set of resources **sequentially**
In contrast to overlays which cannot alter the same baser resources because they clone and extend them **in parallel**
- Components cannot be applied directly by themselves - they must be included within Kustomization file


## components/kustomization.yaml
apiVersion: kustomize.config.k8s.io/v1alpha1
kind: Component

secretGenerator:
- name: ldappass
  files:
    - ldappass.txt

patchesStrategicMerge:
  - configmap.yaml

patchesJson6902:
- target:
    group: apps
    version: v1
    kind: Deployment
    name: example
  path: deployment.yaml

## /overlays/enterprise/kustomization.yaml
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

resources:
  - ../../base

components:
  - ../../components/external_db
  - ../../components/ldap


## Example workspace using components
├── base
│   ├── deployment.yaml
│   └── kustomization.yaml
├── components
│   ├── external_db
│   │   ├── configmap.yaml
│   │   ├── dbpass.txt
│   │   ├── deployment.yaml
│   │   └── kustomization.yaml
│   ├── ldap
│   │   ├── configmap.yaml
│   │   ├── deployment.yaml
│   │   ├── kustomization.yaml
│   │   └── ldappass.txt
│   └── recaptcha
│       ├── deployment.yaml
│       ├── kustomization.yaml
│       ├── secret_key.txt
│       └── site_key.txt
└── overlays
    ├── community
    │   └── kustomization.yaml
    ├── dev
    │   └── kustomization.yaml
    └── enterprise
        └── kustomization.yaml
> kustomize build overlays/community
> kustomize build overlays/enterprise
> kustomize build overlays/dev