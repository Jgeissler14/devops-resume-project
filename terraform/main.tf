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

module "helm-config" {
  source     = "./helm"

  depends_on = [module.kubernetes-config]
}