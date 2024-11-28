# Setting up Kind (Kubernetes IN Docker) on Linux

This guide explains how to set up **[Kind (Kubernetes IN Docker)](https://kind.sigs.k8s.io/)** on a Linux machine.

**Kind** is a tool for running local Kubernetes clusters using Docker containers as nodes. It's primarily designed for testing Kubernetes itself but can also be used for local development or Continuous Integration (CI) workflows. Kind is particularly lightweight and doesn't require a full virtual machine setup, making it an excellent choice for quick setups and testing.

---

## Features of Kind

- Runs Kubernetes clusters in Docker containers.
- Supports multi-node (including HA) clusters.
- Compatible with Kubernetes CI testing requirements.
- Lightweight and easy to install.
- Works well on local systems and CI environments.

---

## Prerequisites

Before proceeding, ensure you have:

1. A Linux-based operating system (Ubuntu).
2. Administrative privileges (sudo access) for installing packages.

---

## Step 1: Install Docker

Docker is a container runtime required for running Kind clusters. Follow these steps to install Docker:

**Run docker-installer script:**
```bash
sh scripts/docker-install.sh
```

---

## Step 2: Install kubectl

`kubectl` is a command-line tool used to interact with Kubernetes clusters.

**Run kubectl-installer script:**
```bash
sh scripts/kubectl-install.sh
```

**Verify Docker and kubectl installation:**
```bash
docker --version
kubectl version --client
```

---

## Step 3: Install Kind

Now that Docker and `kubectl` are installed, you can install Kind.

**Run kind-installer script:**
```bash
sh scripts/kind-install.sh
```

---

## Step 4: Create a Kubernetes Cluster

Use the following command to create a local Kubernetes cluster with Kind:

```bash
kind create cluster --config=config.yaml
```

Verify cluster information:
```bash
kubectl cluster-info --context kind-kind
```

This will create a 4-node Kubernetes cluster named `kind`.

---

## Step 5: FastAPI Git Repository Cloning

This allows you to clone a Git repository using a FastAPI server. The server accepts a POST request with a Git repository URL and clones it to a local directory.

### Prerequisites

Make sure you have the following installed:

- Python3
- `pip` (Python package manager)

### Install Python 3, pip, and virtual environment

```bash
sudo apt install python3 python3-pip -y
sudo apt install python3-venv -y
```

### Set up a Virtual Environment
```bash
python3 -m venv venv
source venv/bin/activate
```

### Install Required Dependencies
Inside the virtual environment, install the required packages:
```bash
pip3 install fastapi uvicorn gitpython
```

### Run the FastAPI Server
```bash
python3 main.py
```

### Clone a Git Repository
Send a POST request to the `/clone-repo/` endpoint with the Git repository URL:
```bash
curl -X 'POST' \
  'http://127.0.0.1:8000/clone-repo/' \
  -H 'Content-Type: application/json' \
  -d '{
  "git_url": "https://github.com/Muntazir17/Go-App.git"
}'
```

---

## Step 6: Running a Pod Inside Kind Cluster

### Build the Docker Image
Build the Docker image from the `Dockerfile`:
```bash
cd cloned_repo
docker build -t username/image:v1 .
```

### Load the Docker Image into the Kind Cluster
Push the locally built Docker image into the Kind cluster:
```bash
kind load docker-image username/image:v1
```

### Apply the Kubernetes Pod Manifest
Deploy the pod using the Kubernetes manifest:
```bash
kubectl apply -f k8s/manifests/pod.yaml
```

### Verify Pod Status
Check the status and details of the deployed pod:
```bash
kubectl get pods -o wide
```

### Clean Up Resources

- **Delete the Kubernetes Resources**:
  ```bash
  kubectl delete -f k8s/manifests/pod.yaml
  ```

- **Remove the Docker Image**:
  ```bash
  docker rmi username/image:v1
  ```

- **Delete the Kind Cluster (Optional)**:
  ```bash
  kind delete cluster
  ```

---

## Additional Resources

- [Kind Official Documentation](https://kind.sigs.k8s.io/)
- [Docker Installation Guide](https://docs.docker.com/engine/install/)
- [kubectl Installation Guide](https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/)

---
