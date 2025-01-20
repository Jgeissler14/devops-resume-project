module "aks-cluster" {
  source       = "./aks-cluster"
  cluster_name = local.cluster_name
  location     = var.location
}

resource "local_file" "kubeconfig" {
  content  = data.azurerm_kubernetes_cluster.default.kube_config_raw
  filename = "${path.root}/kubeconfig"
}
