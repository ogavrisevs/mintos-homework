resource "kubernetes_namespace" "homework" {
  metadata {
    name = "homework"
  }
  depends_on = [null_resource.install_minikube]
}
