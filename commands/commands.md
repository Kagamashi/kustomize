**kustomize build:** Generates the final Kubernetes YAML configuration.
**kustomize edit:** Allows programmatic modification of the kustomization.yaml file.
**kustomize diff:** Compares the Kustomization output with live resources on a Kubernetes cluster to identify changes before deployment.

---

# kustomize build 
is used to generate kubernetes manifests based on the configuration defined in kustomization.yaml

> kustomize build [directory]
> kustomize build ./overlays/prod
[directory] arguments is the path to kustomization.yaml


# kustomize edit
allows to modify kustomization.yaml file without directly editing it manually

Adds resource to kustomization.yaml
> kustomize edit add resource deployment.yaml

Adds patch to kustomization.yaml
> kustomize edit add patch patch.yaml

Adds ConfigMap entry to kustomization.yaml
> kustomize edit add configmap my-config --from-literal key=value

Set fields like image version, name prefixes or labels 
> kustomize edit set image my-image:1.2.3


# kustomize diff
compares output of the current Kustomiztion build against an already applies set of resources in live kubernetes cluster

> kustomize diff [flags] [kube-context] [directory]
> kustomize diff --context prod-cluster ./overlays/prod
[kube-context] specifies context of Kubernetes cluster configured in kubeconfig
[directory] specifies directory with kustomization.yaml
