# Start from a lightweight base image
FROM debian:bullseye-slim

# Install curl and other dependencies
RUN apt-get update && apt-get install -y \
    curl \
    ca-certificates \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install kubectl
RUN curl -LO "https://dl.k8s.io/release/v1.32.2/bin/linux/amd64/kubectl" && \
    chmod +x kubectl && \
    mv kubectl /usr/local/bin/

# Install Argo Rollouts CLI
RUN curl -LO "https://github.com/argoproj/argo-rollouts/releases/latest/download/kubectl-argo-rollouts-linux-amd64" && \
    chmod +x ./kubectl-argo-rollouts-linux-amd64 && \
    mv ./kubectl-argo-rollouts-linux-amd64 /usr/local/bin/kubectl-argo-rollouts

# Verify installations
RUN kubectl version --client && \
    kubectl-argo-rollouts version
