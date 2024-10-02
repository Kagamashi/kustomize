Transformers add changes across every Kubernetes resource that is part of Kustomize configuration.

**commonAnnotations:** Adds uniform annotations to all resources, often for metadata or tracking.
**commonLabels:** Applies labels to all resources for identification, grouping, or filtering purposes.
**namePrefix:** Adds a prefix to the names of all resources, useful for environment-based naming (e.g., dev-, prod-).
**nameSuffix:** Appends a suffix to resource names, often used for versioning or distinguishing resource sets.

---

# CommonAnnotations
Kustomize automatically applies these annotations to each resource in the configuration 

commonAnnotations:
  annotation-key: annotation-value

commonAnnotations:
  environment: production
  owner: team-a


# CommonLabels
Kustomize automatically applies these labels to each resource in the configuration 

commonLabels:
  label-key: label-value

commonLabels:
  app: my-app
  tier: frontend

---

# NamePrefix
Useful for differentiating resources across environments

namePrefix: prefix-
namePrefix: prod-


# NameSuffix
Useful for versioning or naming conventions that needs a suffix

nameSuffix: -suffix
nameSuffix: -v2
