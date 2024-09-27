Kustomize allows for custom extensions through plugins to specific needs that go beyong built-in features.

Types of plugins:
- **generators** used to dynamically create resources like ConfigMaps, Secrets or any other Kubernetes resources
- **transformers** used to modify existing resources by adding, removing or altering fields, labels and more..

**KUSTOMIZE_PLUGIN_HOME** environment variable for plugins path directory which is structure by 
API group, version and plugin name

When running Kustomize use **--enable-alpha-plugins** to enable plugins
> kustomize build --enable-alpha-plugins ./overlays/dev


## CUSTOM GENERATOR
$KUSTOMIZE_PLUGIN_HOME
└── mycompany.example.com
    └── v1
        └── customconfiggenerator
            └── CustomConfigGenerator.yaml

**CustomConfigGenerator.yaml**
apiVersion: mycompany.example.com/v1
kind: CustomConfigGenerator
metadata:
  name: custom-config
spec:
  key: custom-value
  filePath: /path/to/config.properties

**example-sciprt.sh**
#!/bin/bash
echo "apiVersion: v1
kind: ConfigMap
metadata:
  name: custom-config
data:
  custom-key: custom-value" > $1

**kustomization.yaml**
generators:
  - mycompany.example.com/v1/customconfiggenerator/CustomConfigGenerator.yaml


## CUSTOM TRANSFORMERS
$KUSTOMIZE_PLUGIN_HOME
└── mycompany.example.com
    └── v1
        └── customlabeltransformer
            └── CustomLabelTransformer.yaml

**CustomLabelTransformer.yaml**
apiVersion: mycompany.example.com/v1
kind: CustomLabelTransformer
metadata:
  name: add-label
labels:
  team: ops
  environment: production

# script that applies transformations to Kubernetes resource passed to it
**example-go.go**
package main

import (
  "sigs.k8s.io/kustomize/kyaml/yaml"
  "sigs.k8s.io/kustomize/kyaml/kio"
)

func main() {
  r := &kio.LocalPackageReader{PackagePath: "./"}
  resources, err := r.Read()
  if err != nil {
    panic(err)
  }

  for _, resource := range resources {
    resource.SetLabel("team", "ops")
    resource.SetLabel("environment", "production")
  }

  w := &kio.LocalPackageWriter{PackagePath: "./"}
  err = w.Write(resources)
  if err != nil {
    panic(err)
  }
}

**kustomization.yaml**
transformers:
  - mycompany.example.com/v1/customlabeltransformer/CustomLabelTransformer.yaml
