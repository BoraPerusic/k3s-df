# Issues and Suggestions

This document outlines issues and inconsistencies found in the repository setup and documentation during the review.

## 1. Missing Makefile
The `README.md` and `docs/RUNBOOK.md` heavily reference a `Makefile` (e.g., `make init`, `make monitoring`, `make get-secret`). However, no `Makefile` exists in the repository root.
*   **Recommendation**: Remove `make` references from documentation and replace them with the actual shell commands or scripts.

## 2. Duplicate and Broken Bootstrap Scripts
The `00-bootstrap/` directory contains both `00-install-base.sh` and `install-base.sh`.
*   `00-install-base.sh` appears to be the correct, up-to-date version.
*   `install-base.sh` contains a typo in the Argo CD install URL (`install.yam`) and is missing configurations (e.g., `ARGOCD_EXEC_TIMEOUT`, `argocd-cm` patching).
*   **Recommendation**: Delete `00-bootstrap/install-base.sh` to avoid confusion.

## 3. `00-bootstrap/03-secrets.sh` Issues
This script seems to be a scratchpad for generating sealed secrets but contains issues:
*   **Typo**: Line 27 contains `ubectl` instead of `kubectl`.
*   **Inconsistency**: It references `sealed-secrets-controller` in `kube-system` in one place and `auth` namespace in others.
*   **Usage**: It is not clear if this script is intended to be run as-is.
*   **Recommendation**: Correct the typo and clarify the script's usage in comments, or move it to a `scripts` folder if it's just a helper tool.

## 4. Documentation Structure
*   `docs/argo.md` contains a specific troubleshooting step for enabling Helm in Kustomize. This is better suited for the `RUNBOOK.md` troubleshooting section rather than a standalone file.
*   `docs/ARCHITECTURE.md` lists `makefile` in the directory structure, which is incorrect.
*   **Recommendation**: Consolidate `argo.md` into `RUNBOOK.md` and update `ARCHITECTURE.md`.
