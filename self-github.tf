resource "github_repository" "self" {
  name = local.self-name

  private = false
}
