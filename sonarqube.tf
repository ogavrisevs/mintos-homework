resource "helm_release" "sonarqube" {
  name       = "sonarqube"
  repository = "https://SonarSource.github.io/helm-chart-sonarqube"
  chart      = "sonarqube"
  namespace  = kubernetes_namespace.homework.metadata[0].name

  values = [
    "${file("${path.module}/sonarqube-cf.yaml")}"
  ]
}

