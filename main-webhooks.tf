resource "github_repository_webhook" "argocd" {
  for_each = toset([
    "argo-cd.nazarewk.pw",
    "argo-cd-application-set.nazarewk.pw"
  ])

  repository = github_repository.k8s-configs

  events = ["push"]

  configuration {
    url          = format("https://%s/api/webhook", each.value)
    content_type = "json"
  }
}
