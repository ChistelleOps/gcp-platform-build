resource "helm_release" "argocd" {
  name             = "argocd"
  namespace        = "argocd"
  create_namespace = true
  repository       = "https://argoproj.github.io/argo-helm"
  version          = "10.11.6"
  chart            = "argocd"

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

      extraObjects = [
        {
          apiVersion = "argoproj.io/v1alpha1"
          kind       = "Application"

          metadata = {
            name      = "root"
            namespace = "argocd"
          }

          spec = {
            project = "default"

            source = {
              repoURL        = "https://github.com/ChistelleOps/gcp-platform-gitops.git"
              targetRevision = "main"
              path           = "bootstrap"
            }

            destination = {
              server    = "https://kubernetes.default.svc"
              namespace = "argocd"
            }

            syncPolicy = {
              automated = {
                selfHeal = true
              }
            }
          }
        }
      ]
    })
  ]
}