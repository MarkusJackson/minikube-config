#!/bin/bash

echo "🔧 Starte Minikube..."
# minikube start --driver=docker
# minikube start --driver=hyperv

echo "🔧 Deploye ArgoCD per Helm mit Chart https://argoproj.github.io/argo-helm..."
helm repo add argo https://argoproj.github.io/argo-helm
helm repo update
helm install argocd argo/argo-cd --namespace argocd --create-namespace

echo "⏳ Warte, bis der Namespace 'argocd' verfügbar ist..."
timeout=60
interval=5
elapsed=0
while [ $elapsed -lt $timeout ]; do
    if kubectl get namespace argocd >/dev/null 2>&1; then
        echo "Namespace 'argocd' gefunden!"
        break
    fi
    echo "Namespace 'argocd' noch nicht verfügbar, warte $interval Sekunden..."
    sleep $interval
    elapsed=$((elapsed + interval))
done
if [ $elapsed -ge $timeout ]; then
    echo "Error: Timeout: Namespace 'argocd' wurde nicht gefunden!"
    exit 1
fi

echo "🌐 Aktiviere Ingress..."
minikube addons enable ingress

echo "⏳ Warte, bis der Ingress-Controller bereit ist..."
kubectl wait --namespace ingress-nginx --for=condition=ready pod --selector=app.kubernetes.io/component=controller --timeout=120s

echo "🚀 Deploye ArgoCD Ingress..."
kubectl apply -f ingress/argocd-ingress.yaml

echo "✅ Setup abgeschlossen!"