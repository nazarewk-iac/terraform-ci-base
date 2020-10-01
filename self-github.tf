resource "github_repository" "self" {
  name = local.self-name

  visibility = "public"
}
