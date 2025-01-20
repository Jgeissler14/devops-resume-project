# Create namespaces first
resource "kubernetes_namespace" "cloudnative_pg" {
  metadata {
    name = "cloudnative-pg"
  }
}

resource "kubernetes_namespace" "monitoring" {
  metadata {
    name = "monitoring"
  }
}

resource "helm_release" "cloudnative_pg" {
    name       = "cnpg"
    repository = "https://cloudnative-pg.github.io/charts"
    chart      = "cloudnative-pg"
    namespace  = "cnpg-system"
    create_namespace = true
}

resource "helm_release" "database" {
    name             = "database"
    repository       = "https://cloudnative-pg.github.io/charts"
    chart            = "cluster"
    namespace        = "database"
    create_namespace = true
}

resource "helm_release" "prometheus" {
    name             = "prometheus-community"
    repository       = "https://prometheus-community.github.io/helm-charts"
    chart            = "kube-prometheus-stack"
    namespace        = "monitoring"
    create_namespace = true

    values = [
        "${path.module}/prometheus_values.yaml"
    ]
}