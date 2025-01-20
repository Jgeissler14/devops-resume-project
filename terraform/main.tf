terraform {
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
    azurerm = {
      source = "hashicorp/azurerm"
    }
    helm = {
      source = "hashicorp/helm"
    }
  }
}

data "azurerm_kubernetes_cluster" "default" {
  depends_on          = [module.aks-cluster] # refresh cluster state before reading
  name                = local.cluster_name
  resource_group_name = local.cluster_name
}

provider "kubernetes" {
  host                   = data.azurerm_kubernetes_cluster.default.kube_config.0.host
  client_certificate     = base64decode(data.azurerm_kubernetes_cluster.default.kube_config.0.client_certificate)
  client_key             = base64decode(data.azurerm_kubernetes_cluster.default.kube_config.0.client_key)
  cluster_ca_certificate = base64decode(data.azurerm_kubernetes_cluster.default.kube_config.0.cluster_ca_certificate)
  # config_path            = "./kubeconfig"
}

provider "helm" {
  kubernetes {
    config_path = "./kubeconfig"
  }
}

provider "azurerm" {
  features {}
  tenant_id       = var.tenant_id
  subscription_id = var.subscription_id
}

module "aks-cluster" {
  source       = "./aks-cluster"
  cluster_name = local.cluster_name
  location     = var.location
}

module "kubernetes-config" {
  depends_on   = [module.aks-cluster]
  source       = "./kubernetes"
  cluster_name = local.cluster_name
  kubeconfig   = data.azurerm_kubernetes_cluster.default.kube_config_raw
}
