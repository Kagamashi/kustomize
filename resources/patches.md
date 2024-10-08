Patches provides more 'surgical' (than Transformers) approach to targeting one or more specific sections of Kubernetes resources

**Basic Patch**: add/override fields on resources
**Strategic Merge Patch:** Modifies Kubernetes resources by merging fields intelligently, understanding the structure of Kubernetes objects.
**JSON Patches:** Provides precise, low-level modifications using a set of operations (add, replace, remove) defined by JSON paths.
**Patch Transforms:** Allows advanced and customizable transformations, often involving multiple resources or complex logic.

---

# Patches (also called overlays)
Require 3 parameters:
- Operation Type: add/remove/replace

Patch target selects resources by:
- group
- version
- kind
- name
- namespace
- labelSelector
- annotationSelector
Any resource which matches all **specified** fields has the patch applied to it.

**kustomization.yaml**
patches:
- path: patch.yaml
  target:
    group: apps
    version: v1
    kind: Deployment
    name: deploy.*
    labelSelector: "env=dev"
    annotationSelector: "zone=west"
- patch: |-
    - op: replace
      path: /some/existing/path
      value: new value    
  target:
    kind: MyKind
    labelSelector: "env=dev"

**allowKindChange** and **allowNameChange** options:
patches:
- path: patch.yaml
  target:
    kind: Deployment
  options:
    allowNameChange: true
    allowKindChange: true


---

# Strategic Merge Patch
Patches resources like Deployments, Services etc. in a declarative way.
Designed to merge with target resource, instead of replacing it entirely.

patchesStrategicMerge:
  - patch.yaml

**deployment.yaml**
apiVersion: apps/v1
kind: Deployment
metadata:
  name: my-app
spec:
  replicas: 3
  template:
    spec:
      containers:
      - name: my-container
        image: nginx:1.14

**patch.yaml**
apiVersion: apps/v1
kind: Deployment
metadata:
  name: my-app
spec:
  replicas: 5
  template:
    spec:
      containers:
      - name: my-container
        image: nginx:1.16

This will update only the replicas and image fields without replacing the entire resource.

---

# JSON Patches
Specify precise changes using a list of operations defined in RFC 6902.
- add, replace, remove operations
- applies changes at specific JSON paths

**deployment.yaml**
apiVersion: apps/v1
kind: Deployment
metadata:
  name: my-app
spec:
  replicas: 3
  template:
    spec:
      containers:
      - name: my-container
        image: nginx:1.14

**kustomization.yaml**
patchesJson6902:
  - target:
      version: apps/v1
      kind: Deployment
      name: my-app
    path: patch.json

**patch.json**
[
  {
    "op": "replace",
    "path": "/spec/template/spec/containers/0/image",
    "value": "nginx:1.16"
  },
  {
    "op": "add",
    "path": "/spec/replicas",
    "value": 5
  }
]

---

# Patch Transforms
Allows to apply changes across multiple resources or perform complex modifications beyond basic merges or JSON patches

**kustomization.yaml**
transformers:
  - custom-transform.yaml

**label-transformer.yaml**
apiVersion: builtin
kind: LabelTransformer
metadata:
  name: not-important
labels:
  app: my-app
fieldSpecs:
  - path: metadata/labels
    kind: Deployment
  - path: metadata/labels
    kind: Service

This will add label **app: my-app** to both **Deployment** and **Service** objects.
