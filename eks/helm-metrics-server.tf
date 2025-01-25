resource "helm_release" "metrics_server" {
  name       = "metrics-server"
  repository = "https://kubernetes-sigs.github.io/metrics-server/"
  chart      = "metrics-server"
  namespace  = "kube-system"
  version    = "3.12.1"

  timeout = 600

  values = [
    file("${path.module}/helm/metrics-server.yaml")
  ]
  depends_on = [aws_eks_node_group.nodes]
}
