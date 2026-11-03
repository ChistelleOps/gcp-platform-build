resource "helm_release" "argocd" {
  name             = "argocd"
  namespace        = "argocd"
  create_namespace = true
  repository       = "https://argoproj.github.io/argo-helm"
  version          = "10.11.6"
  chart            = "argo-cd"

  wait    = true
  timeout = 600

  values = [
    yamlencode({
      server = {
        service = {
          type = "ClusterIP"
        }
      }
      dex = {
        enabled = false
      }

      notifications = {
        enabled = false
      }

      applicationSet = {
        enabled = false
      }
    })
  ]
}