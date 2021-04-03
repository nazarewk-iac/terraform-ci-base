resource "github_repository" "packer-rpi-k3s" {
  name = "packer-rpi-k3s"

  visibility = "public"
}

resource "github_repository" "rpi4-k3os" {
  name = "rpi4-k3os"

  visibility = "public"
}

resource "github_repository" "buildah-arm64" {
  name = "buildah-arm64"

  description = "arm64 compatible build of https://github.com/containers/buildah/blob/master/contrib/buildahimage/stable"

  visibility = "public"
  auto_init  = true
}

resource "github_repository" "build-vault-k8s-arm64" {
  name = "build-vault-k8s-arm64"

  description = "arm64 build of https://github.com/hashicorp/vault-k8s"

  visibility = "public"
  auto_init  = true
}

resource "github_repository" "rpi-container-image-builder" {
  name = "rpi-container-image-builder"

  description = "image for more easily building further images on/for Raspberry Pi 4 Kubernetes cluster"

  visibility = "public"
  auto_init  = true
}

resource "github_repository" "external-dns-arm64" {
  name = "external-dns-arm64"

  description = "arm64 compatible build of https://github.com/kubernetes-sigs/external-dns"

  visibility = "public"
  auto_init  = true
}

resource "github_repository" "k3os-configs" {
  name = "k3os-configs"

  description = "Repository containing various means to configure k3os"

  visibility = "public"
  auto_init  = true
}

resource "github_repository" "nixpi" {
  name = "nixpi"

  description = "Repository containing NixOs on Raspberry Pi (nixpi) configurations"

  visibility = "public"
  auto_init  = true
}

resource "github_repository" "terraform-provider-custom" {
  name = "terraform-provider-custom"

  description = "Terraform resources defined with arbitrary commands"

  visibility = "public"
  auto_init  = true
}

resource "github_repository" "archpi" {
  name = "archpi"

  description = "Repository containing ArchLinuxARM on Raspberry Pi 4 configurations https://archlinuxarm.org"

  visibility = "public"
  auto_init  = true
}


locals {
  repositories = { for repo in [
    github_repository.archpi,
    github_repository.build-vault-k8s-arm64,
    github_repository.buildah-arm64,
    github_repository.external-dns-arm64,
    github_repository.k3os-configs,
    github_repository.nixpi,
    github_repository.packer-rpi-k3s,
    github_repository.rpi-container-image-builder,
    github_repository.rpi4-k3os,
    github_repository.self,
    github_repository.terraform-provider-custom,
  ] : repo.name => repo }


}

resource "github_branch_default" "masters" {
  for_each = local.repositories

  branch = "master"
}

resource "github_branch_protection" "masters" {
  for_each = local.repositories

  repository_id = each.value.name

  pattern = github_branch_default.masters[each.key].branch

  require_signed_commits = true
}
