locals { ns = "karpenter" }

resource "kubernetes_namespace" "karpenter" {
  metadata { name = local.ns }
}

resource "helm_release" "karpenter" {
  name       = "karpenter"
  repository = "https://charts.karpenter.sh"
  chart      = "karpenter"
  namespace  = local.ns
  version    = "v0.37.0"

  set {
    name  = "settings.clusterName"
    value = var.cluster_name
  }
  set {
    name  = "settings.interruptionQueueName"
    value = "${var.cluster_name}"
  }
}