# Replacements 
Used to modify values in our manifests based on other resource fields.

Usefu for injecting values like Secret data, ConfigMap keys..

## secret.yaml
apiVersion: v1
kind: Secret
metadata:
  name: db-secret
type: Opaque
data:
  db_password: c2VjcmV0cGFzc3dvcmQ=  # base64 encoded "secretpassword"

## deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: my-app
spec:
  template:
    spec:
      containers:
        - name: my-container
          image: nginx
          env:
            - name: DB_PASSWORD
              value: "REPLACEME"

## kustomization.yaml
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

resources:
  - secret.yaml
  - deployment.yaml

replacements:
  - source:
      kind: Secret
      name: db-secret
      fieldPath: data.db_password  # Path to the base64-encoded password
    targets:
      - select:
          kind: Deployment
          name: my-app
        fieldPaths:
          - spec.template.spec.containers[0].env[0].value  # Replace "REPLACEME" in env


**source:** The source field that contains the value to be injected. Here, the password in the Secret (data.db_password) is the source.
**targets:** The target location where the source value will be injected. In this case, it’s the env[0].value field of the first container in the Deployment resource.
