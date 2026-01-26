# k3s-df: Argo CD App-of-Apps Setup

This repository contains the Infrastructure as Code (IaC) and Application definitions for a Kubernetes cluster managed by Argo CD.

## Documentation

We have prepared detailed documentation for different audiences:

*   **[Managerial Overview](docs/OVERVIEW.md)**: High-level explanation of the "App-of-Apps" pattern and its benefits.
*   **[Technical Architecture](docs/ARCHITECTURE.md)**: Detailed breakdown of the repository structure and how components interact.
*   **[Runbook](docs/RUNBOOK.md)**: Operational guides for updates, debugging, and maintenance.

## Quick Start

### Prerequisites
*   A Linux machine (or VM) to act as the node.
*   `sudo` access.
*   `kubectl` and `helm` installed (optional, the bootstrap script installs them if missing).

### Installation
The `00-bootstrap/` directory contains the scripts to install K3s and Argo CD from scratch.

Refer to `00-bootstrap/00-install-base.sh` for the step-by-step installation procedure. This script serves as a runbook for bootstrapping the cluster.

```bash
# Example of commands found in the bootstrap script:
./00-bootstrap/00-install-base.sh
```

### Accessing Dashboards
To access the Grafana dashboard:
```bash
kubectl port-forward -n monitoring svc/prom-stack-grafana 3000:80
```
Then open `http://localhost:3000`.

To get the Grafana admin password:
```bash
kubectl get secret --namespace monitoring grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo
```

## Repository Structure

*   `00-bootstrap`: Initial cluster setup scripts and manifests.
*   `clusters/`: Contains cluster-specific configurations (e.g., `bp-dsk`, `df-test`).
    *   `applications/`: The specific applications enabled for each cluster.
*   `platform`: Helm charts and configuration for infrastructure components.
*   `root-app-bp-dsk.yaml` / `root-app-df-test.yaml`: The main entry points for Argo CD for each cluster.
