# Justfile for k3s-df

# Initialize the cluster and install Argo CD
init:
    ./00-bootstrap/00-install-base.sh

# Port-forward Grafana to localhost:3000
monitoring:
    @echo "Access Grafana at http://localhost:3000"
    kubectl port-forward -n monitoring svc/prom-stack-grafana 3000:80

# Port-forward Argo CD to localhost:8080
argocd:
    @echo "Access Argo CD at https://localhost:8080"
    kubectl port-forward svc/argocd-server -n argocd 8080:443

# Get the initial admin password for Grafana
get-grafana-password:
    @kubectl get secret --namespace monitoring grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo

# Restart a specific deployment
# Usage: just restart <deployment-name> <namespace>
restart deployment namespace="default":
    kubectl rollout restart deployment {{deployment}} -n {{namespace}}

# Launch k9s (Terminal UI)
k9s:
    k9s

# Enable Helm support in Argo CD Kustomize (Troubleshooting fix)
fix-argocd-helm:
    kubectl patch cm argocd-cm -n argocd --type merge -p '{"data":{"kustomize.buildOptions":"--enable-helm --load-restrictor LoadRestrictionsNone"}}'
    kubectl rollout restart deploy argocd-repo-server -n argocd
