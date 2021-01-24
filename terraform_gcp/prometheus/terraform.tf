provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = "gke_traefikproject_us-central1-c_traefikv6"
}

resource "helm_release" "prometheus" {
  name       = "prometheus-helm"

  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "prometheus"

  #values = [
  #  "${file("values.yaml")}"
  #]

  namespace = "monitoring"
}

resource "helm_release" "grafana" {
  name       = "grafana-helm"

  repository = "https://grafana.github.io/helm-charts"
  chart      = "grafana"

  values = [
    "${file("grafana-values.yaml")}"
  ]

  namespace = "monitoring"
}

resource "kubernetes_namespace" "monitoring" {
  metadata {
    name = "monitoring"
  }
}