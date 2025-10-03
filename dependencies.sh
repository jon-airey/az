# Update package lists
sudo apt update && sudo apt upgrade -y

# JSON parsing
sudo apt install jq

# Install Azure CLI via Microsoft-provided script
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

# Bicep CLI (via Azure CLI)
az bicep install

# kubectl (via Azure CLI is fine, or manually)
az aks install-cli

# Optional, for editing YAML nicely
sudo apt install yq

# docker – if you’re building images locally before pushing to ACR.
<!-- sudo apt install -y docker.io
sudo systemctl enable --now docker
sudo usermod -aG docker $USER -->

# had issues installing kubectl with az, this is manual way, also used snap
<!-- VERSION=$(curl -Ls https://dl.k8s.io/release/stable.txt)
curl -LO "https://dl.k8s.io/release/$VERSION/bin/linux/amd64/kubectl"
chmod +x kubectl
sudo mv kubectl /usr/local/bin/
kubectl version --client -->