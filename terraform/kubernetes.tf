# This will eventually be helm charts
resource "kubernetes_namespace" "api" {
    metadata {
        name = "api"
    }
}

resource "kubernetes_deployment" "api" {
    metadata {
        name      = "api-deployment"
        namespace = kubernetes_namespace.api.metadata[0].name
    }

    spec {
        replicas = 1

        selector {
            match_labels = {
                app = "api"
            }
        }

        template {
            metadata {
                labels = {
                    app = "api"
                }
            }

            spec {
                container {
                    name  = "api-container"
                    image = "ghcr.io/${var.username}/devops-python:latest"

                    resources {
                        limits = {
                            cpu    = "0.5"
                            memory = "512Mi"
                        }
                        requests = {
                            cpu    = "0.25"
                            memory = "256Mi"
                        }
                    }

                    liveness_probe {
                        http_get {
                            path = "/health"
                            port = 80
                        }
                        initial_delay_seconds = 3
                        period_seconds         = 3
                    }
                }
            }
        }
    }
}

resource "kubernetes_service" "api" {
    metadata {
        name      = "api-service"
        namespace = kubernetes_namespace.api.metadata[0].name
    }

    spec {
        selector = {
            app = "api"
        }

        port {
            port        = 80
            target_port = 80
        }
    }
}

