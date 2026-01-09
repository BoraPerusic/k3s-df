
# 1. Update system
sudo apt update && sudo apt upgrade -y

# 2. Install basic utilities
sudo apt install -y curl unzip git

# 3. Disable Swap (Critical for K8s stability)
sudo swapoff -a
# Keep swap off after reboot by commenting out the swap line in fstab
sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab

# 4. (Optional) If you use UFW firewall, open these internal ports
# K3s needs 6443 (API), 10250 (Metrics), and 8472 (Flannel VXLAN)
sudo ufw allow 6443/tcp
sudo ufw allow 10250/tcp
sudo ufw allow 8472/udp
# Allow your Gateway traffic
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp

curl -sfL https://get.k3s.io | sh -

# Create .kube directory
mkdir -p ~/.kube

# Copy the config from K3s location to standard K8s location
sudo cp /etc/rancher/k3s/k3s.yaml ~/.kube/config

# Change ownership to your current user
sudo chown $(id -u):$(id -g) ~/.kube/config

# Set permission restrictive (good practice)
chmod 600 ~/.kube/config

# Add useful alias and auto-completion to your shell
echo 'source <(kubectl completion bash)' >> ~/.bashrc
echo 'alias k=kubectl' >> ~/.bashrc
echo 'complete -F __start_kubectl k' >> ~/.bashrc
source ~/.bashrc







export KUBECONFIG=~/.kube/config



# Check the node status
kubectl get nodes

# Check the system pods (Traefik, DNS, etc.)
kubectl get pods -A


# Download and install k9s
curl -sS https://webinstall.dev/k9s | bash

# You might need to source profile again or restart terminal
source ~/.config/envman/PATH.env


sudo snap install helm --classic
