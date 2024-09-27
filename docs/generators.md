**SecretGenerator:** Dynamically generates Kubernetes Secrets from literals, files, or environment variables, and automatically appends a hash for versioning.
**ConfigMapGenerator:** Dynamically generates ConfigMaps with configuration data, and similarly, appends a hash for versioning.


## Generating Secrets
Generate Secrets dynamically based on literal values, files or environmental variabls

- **literals:** Provides key-value pairs as string literals.
- **files:** Specifies file paths whose content will be encoded and added as data to the Secret.
- **envs:** Points to a file containing environment variables (in the form KEY=VALUE) loaded into the Secret

**kustomization.yaml**
secretGenerator:
  - name: db-credentials
    literals:
      - username=admin
      - password=securepass123
    files:
      - ssh-key=/path/to/ssh-keyfile

This will generate a Secret named db-credentials with username, password and content of ssh-key as part of the Secret.


# Generating ConfigMaps
Generate ConfigMaps dynamically from literal values, files, or environment variables.

- **literals:** Provides key-value pairs as string literals.
- **files:** Specifies file paths whose content will be added to the ConfigMap.
- **envs:** Points to a file with environment variables in KEY=VALUE format to be included in the ConfigMap.

configMapGenerator:
  - name: app-config
    literals:
      - key1=value1
      - key2=value2
    files:
      - /path/to/config.properties
    envs:
      - config.env
