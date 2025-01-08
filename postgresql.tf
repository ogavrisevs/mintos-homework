resource "helm_release" "postgresql" {
  name       = "postgresql"
  repository = "oci://registry-1.docker.io/bitnamicharts"
  chart      = "postgresql"
  version    = "16.3.5"
  namespace  = kubernetes_namespace.homework.metadata[0].name

  values = [
    "${file("${path.module}/postgresql-cfg.yaml")}"
  ]
  depends_on = [kubernetes_namespace.homework]
}