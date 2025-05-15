#!/bin/bash

kubectl_context=$(kubectl config current-context)
kubectl_namespace=$(kubectl config view --minify --output 'jsonpath={..namespace}')

echo "$kubectl_context/$kubectl_namespace"

