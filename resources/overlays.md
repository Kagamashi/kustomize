# Overlays
Overlays are environment-specific customizations applied to a base. They typically patch or modify the base resources to meet the needs of a specific environment (e.g., adding a different namePrefix or modifying image versions).

**overlays/prod/kustomization.yaml**
bases:
  - ../../base
namePrefix: prod-

- overlays/ directory:
Contains subdirectories for each environment (dev/, staging/, prod/), each with its own kustomization.yaml file that applies environment-specific customizations using patches or transformations.
