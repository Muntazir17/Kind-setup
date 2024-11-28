#!/bin/bash

set -e  # Exit immediately if a command exits with a non-zero status

echo "############################################################################"
echo "#                                                                          #"
echo "#                  kubectl Installer for Ubuntu                            #"
echo "#                                                                          #"
echo "############################################################################"
echo ""

# Step 1: Download the latest stable version of kubectl
echo "Downloading the latest version of kubectl..."
KUBECTL_VERSION=$(curl -L -s https://dl.k8s.io/release/stable.txt)
curl -LO "https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl"

# Step 2: Make kubectl binary executable
echo "Making kubectl binary executable..."
chmod +x kubectl

# Step 3: Move the binary to a directory in the PATH
echo "Moving kubectl binary to /usr/local/bin..."
sudo mv kubectl /usr/local/bin/

# Step 4: Verify kubectl installation
echo "Verifying kubectl installation..."
if kubectl version --client; then
	  echo "kubectl installed successfully!"
  else
	    echo "kubectl installation failed!"
	      exit 1
fi

echo "############################################################################"
echo "#                                                                          #"
echo "#                  kubectl Installation Completed                          #"
echo "#                                                                          #"
echo "############################################################################"

