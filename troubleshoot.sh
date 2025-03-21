#!/bin/bash

echo "🔍 Checking Minikube Status..."

minikube status

echo "🛠️ Checking Kubernetes Resources..."

kubectl get pods -n mini-demo

kubectl get services -n mini-demo

kubectl logs -l app=flask-app -n mini-demo

If the pod is not running:

kubectl describe pod <pod-name> -n mini-demo

kubectl logs <pod-name> -n mini-demo

If Minikube is down:

minikube stop && minikube delete

minikube start --driver=docker