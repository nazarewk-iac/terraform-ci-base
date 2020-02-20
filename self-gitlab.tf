resource "gitlab_group" "self" {
  name = var.gitlab_group
  path = var.gitlab_group
}

resource "gitlab_project" "self" {
  name = local.self-name
}
