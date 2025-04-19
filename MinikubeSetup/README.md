# Minikube Dev Setup

Dies ist eine Sammlung von Konfigurationsdateien und Befehlen, um eine lokale Minikube-Umgebung für die Entwicklung mit ArgoCD und Tekton schnell aufzusetzen.

## 🔧 Setup

1. **Minikube starten:**

```bash
minikube start --driver=docker
```

2. **Ingress aktivieren:**

```bash
minikube addons enable ingress
```

3. **Argo CD Ingress anwenden:**

```bash
kubectl apply -f ingress/argocd-ingress.yaml
```

4. **Windows Hosts-Datei aktualisieren:**

Öffne `C:\Windows\System32\drivers\etc\hosts` als Administrator und füge hinzu:

```
127.0.0.1  argocd.local
```

Dann erreichst du Argo CD unter [https://argocd.local](https://argocd.local).

## 🐙 GitOps Setup

- Argo CD wird per Ingress erreichbar gemacht.
- Tekton wurde über ein Helm Chart via Argo CD deployt.

## 🔄 Nach PC-Neustart

Nur noch `minikube start` und alles ist wie vorher.

---