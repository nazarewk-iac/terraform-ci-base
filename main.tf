resource "github_repository" "packer-rpi-k3s" {
  name = "packer-rpi-k3s"
}

resource "github_repository" "rpi4-k3os" {
  name = "rpi4-k3os"

  private = false
}

locals {
  repositories = [
    github_repository.rpi4-k3os,
    github_repository.packer-rpi-k3s,
    github_repository.self
  ]
}

resource "github_branch_protection" "masters" {
  for_each = {for repo in local.repositories : repo.name => repo}

  repository = each.key

  branch = "master"

  require_signed_commits = true
}
