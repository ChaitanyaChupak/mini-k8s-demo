#!/bin/bash  
set -e  

echo "🚀 Starting Minikube..."  
minikube start --driver=docker  

echo "🐳 Setting up Docker..."  
eval $(minikube docker-env)  

echo "🛠️ Building Docker Image..."  
docker build -t mini-k8s-demo:latest app/  

echo "📌 Deploying to Kubernetes..."  
kubectl apply -f k8s/namespace.yaml  
kubectl apply -f k8s/configmap.yaml  
kubectl apply -f k8s/deployment.yaml  
kubectl apply -f k8s/service.yaml  

echo "✅ Deployment complete! Access the app using:"  
minikube service flask-service -n mini-demo --url  
