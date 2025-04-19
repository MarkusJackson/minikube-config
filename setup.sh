#!/bin/bash

# Das muss nur einal nach Erstellen eines neuen Containers ausgeführt werden.

echo "🔧 Starte Minikube..."
minikube start --driver=docker

echo "🌐 Aktiviere Ingress..."
minikube addons enable ingress

echo "🚀 Deploye ArgoCD Ingress..."
kubectl apply -f ingress/argocd-ingress.yaml

echo "✅ Setup abgeschlossen!"
