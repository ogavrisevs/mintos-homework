resource "helm_release" "sonarqube" {
  name       = "sonarqube"
  repository = "oci://registry-1.docker.io/bitnamicharts"
  chart      = "sonarqube"
  version    = "6.2.0"
  namespace  = kubernetes_namespace.homework.metadata[0].name

  values = [
    "${file("${path.module}/sonarqube-cfg.yaml")}"
  ]
  depends_on = [null_resource.install_helm]
}

