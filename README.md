# To set-up Azure CLI on MacOs, install Homewbrew 
https://learn.microsoft.com/en-us/cli/azure/install-azure-cli-macos 

# To connect to Azure Kubernetes Service via VS code, follow this link: 

# Learn Terraform - Provision AKS Cluster

This repo is a companion repo to the [Provision an AKS Cluster tutorial](https://developer.hashicorp.com/terraform/tutorials/kubernetes/aks), containing Terraform configuration files to provision an AKS cluster on Azure.

To deploy the Kubernetes Dashboard, run these two commands in cloudshell once the cluster is up and running: 

# Before applying the code, run the command to create your Service principal's (you need a Contributor Service Principal — enough permissions to create and delete resources) password and id credentials. 
az ad sp create-for-rbac --skip-assignment

# Add kubernetes-dashboard repository
helm repo add kubernetes-dashboard https://kubernetes.github.io/dashboard/
# Deploy a Helm Release named "kubernetes-dashboard" using the kubernetes-dashboard chart
helm upgrade --install kubernetes-dashboard kubernetes-dashboard/kubernetes-dashboard --create-namespace --namespace kubernetes-dashboard

# To access the kubernetes dashboard, use this command
az aks browse --resource-group $(terraform output -raw resource_group_name) --name $(terraform output -raw kubernetes_cluster_name)

# https://kubernetes.io/docs/tasks/access-application-cluster/web-ui-dashboard/
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.7.0/aio/deploy/recommended.yaml 

# Source for the ak cluster building: https://developer.hashicorp.com/terraform/tutorials/kubernetes/aks    OR       https://learnk8s.io/terraform-aks 