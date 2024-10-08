Variables in Kustomize allow to dynmically reference values like Service names, Secret or other fields from our Kubernetes resources.
These values can be used to inject dynamic content into other resources.

**kustomization.yaml**
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

resources:
  - service.yaml
  - deployment.yaml

vars:
  - name: SERVICE_NAME
    objref:
      kind: Service
      name: my-service
      apiVersion: v1
    fieldref:
      fieldpath: metadata.name

# Variable fields
- vars: The vars section is where you define your variables.
- name: The name of the variable that will be referenced in other resources (e.g., SERVICE_NAME).
- objref: Specifies the object reference, including the resource kind (Service), name (my-service), and its API version (v1).
- fieldref: Specifies the field in the referenced object to extract (e.g., metadata.name).

**deployment.yaml**
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
            - name: MY_SERVICE
              value: "$(SERVICE_NAME)"
