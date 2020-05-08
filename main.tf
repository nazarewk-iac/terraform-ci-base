resource "github_repository" "packer-rpi-k3s" {
  name = "packer-rpi-k3s"

  private = false
}

resource "github_repository" "rpi4-k3os" {
  name = "rpi4-k3os"

  private = false
}

resource "github_repository" "buildah-arm64" {
  name = "buildah-arm64"

  description = "arm64 compatible build of https://github.com/containers/buildah/blob/master/contrib/buildahimage/stable"

  private = false
  auto_init = true
}

resource "github_repository" "external-dns-arm64" {
  name = "external-dns-arm64"

  description = "arm64 compatible build of https://github.com/kubernetes-sigs/external-dns"

  private = false
  auto_init = true
}

resource "github_repository" "k3os-configs" {
  name = "k3os-configs"

  description = "Repository containing various means to configure k3os"

  private = false
  auto_init = true
}

locals {
  repositories = [
    github_repository.buildah-arm64,
    github_repository.external-dns-arm64,
    github_repository.k3os-configs,
    github_repository.packer-rpi-k3s,
    github_repository.rpi4-k3os,
    github_repository.self,
  ]
}

resource "github_branch_protection" "masters" {
  for_each = {for repo in local.repositories : repo.name => repo}

  repository = each.key

  branch = "master"

  require_signed_commits = true
}
