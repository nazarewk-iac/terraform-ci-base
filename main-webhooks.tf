resource "github_repository_webhook" "argocd" {
  for_each = contains(var.features, "webhooks") ? toset([
    # "argo-cd.nazarewk.pw",
    # "argo-cd-application-set.nazarewk.pw"
  ]) : []

  repository = github_repository.k8s-configs.name

  events = ["push"]

  configuration {
    url          = format("https://%s/api/webhook", each.value)
    content_type = "json"
  }
}
