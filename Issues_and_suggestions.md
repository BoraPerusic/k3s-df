# Issues and Suggestions

This document tracks issues and inconsistencies identified in the repository setup.

## Inconsistencies between Clusters (`bp-dsk` vs `df-test`)

### 1. Repository URL in ApplicationSets
*   **File**: `clusters/bp-dsk/appset.yaml` vs `clusters/df-test/appset.yaml`
*   **Issue**: The `repoURL` differs between the two clusters.
    *   `bp-dsk`: `https://github.com/BoraPerusic/k3s-df.git`
    *   `df-test`: `https://github.com/DFPartner/fabric-infra.git`
*   **Suggestion**: Verify if this is intentional (e.g., different upstream repos) or a misconfiguration. Ideally, both should point to the repository where this code resides.

### 2. Certificate Specifications
*   **File**: `clusters/bp-dsk/certificate.yaml` vs `clusters/df-test/certificate.yaml`
*   **Issue**: `bp-dsk` includes `dnsNames` (`bp-dsk.local`, `bp-dsk.lan`) in addition to IP addresses. `df-test` only includes `ipAddresses`.
*   **Suggestion**: Standardize the certificate requirements. If `df-test` needs DNS access, add the appropriate DNS names.

### 3. Issuer Naming Convention
*   **File**: `clusters/*/sys-cert-manager/ca-issuer.yaml` and `certificate.yaml`
*   **Issue**: Issuers are prefixed with the cluster name (`bp-dsk-ca-issuer` vs `df-test-ca-issuer`).
*   **Suggestion**: This forces configuration changes for what should be a standard component. Consider using a generic name (e.g., `cluster-ca-issuer`) within the cluster scope if possible, or accept this as a necessary divergence.

## General Repository Issues

### 1. Directory Structure Mismatch in Documentation
*   **Issue**: Previous documentation (`README.md`, `docs/*`) referenced `apps/templates/` as the location for application definitions. The actual structure is `clusters/<cluster-name>/applications/`.
*   **Status**: Documentation updated in this PR.

### 2. Missing `justfile`
*   **Issue**: Operational expectations (per memory/handover) mentioned a `justfile` for managing tasks, but it is not present in the repository root.
*   **Suggestion**: Reinstate the `justfile` if it contained useful shortcuts, or document the replacement commands (currently manual `kubectl` and scripts).

### 3. Bootstrap Script Specifics
*   **File**: `00-bootstrap/00-install-base.sh`
*   **Issue**: The script is a manual runbook containing steps like `kubectl apply -f 02-projects-<XXX>.yaml`. It does not automatically detect the cluster context to apply the correct project file (`02-projects-bp-dsk.yaml` or `02-projects-df-test.yaml`).
*   **Suggestion**: Automate the script to accept a cluster name argument and apply the corresponding resources.

### 4. Obsolete Local Overlays
*   **Issue**: Existence of "local" overlays or configurations that are marked as obsolete.
*   **Suggestion**: Remove these files if they are no longer needed to reduce confusion.
