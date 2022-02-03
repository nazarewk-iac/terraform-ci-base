resource "github_repository" "packer-rpi-k3s" {
  name = "packer-rpi-k3s"

  visibility             = "public"
  delete_branch_on_merge = true
}

resource "github_repository" "rpi4-k3os" {
  name = "rpi4-k3os"

  visibility             = "public"
  delete_branch_on_merge = true
}

resource "github_repository" "buildah-arm64" {
  name = "buildah-arm64"

  description = "arm64 compatible build of https://github.com/containers/buildah/blob/master/contrib/buildahimage/stable"

  visibility             = "public"
  auto_init              = true
  delete_branch_on_merge = true
}

resource "github_repository" "build-vault-k8s-arm64" {
  name = "build-vault-k8s-arm64"

  description = "arm64 build of https://github.com/hashicorp/vault-k8s"

  visibility             = "public"
  auto_init              = true
  delete_branch_on_merge = true
}

resource "github_repository" "rpi-container-image-builder" {
  name = "rpi-container-image-builder"

  description = "image for more easily building further images on/for Raspberry Pi 4 Kubernetes cluster"

  visibility             = "public"
  auto_init              = true
  delete_branch_on_merge = true
}

resource "github_repository" "external-dns-arm64" {
  name = "external-dns-arm64"

  description = "arm64 compatible build of https://github.com/kubernetes-sigs/external-dns"

  visibility             = "public"
  auto_init              = true
  delete_branch_on_merge = true
}

resource "github_repository" "k3os-configs" {
  name = "k3os-configs"

  description = "Repository containing various means to configure k3os"

  visibility             = "public"
  auto_init              = true
  delete_branch_on_merge = true
}

resource "github_repository" "nixpi" {
  name = "nixpi"

  description = "Repository containing NixOS on Raspberry Pi (nixpi) configurations"

  visibility             = "public"
  auto_init              = true
  delete_branch_on_merge = true
}

resource "github_repository" "nix-configs" {
  name = "nix-configs"

  description = "Repository containing my personal Nix (NixOS, Home Manager etc.) configurations"

  visibility             = "public"
  auto_init              = true
  delete_branch_on_merge = true
}

resource "github_repository" "terraform-provider-custom" {
  name = "terraform-provider-custom"

  description = "Terraform resources defined with arbitrary commands"

  visibility             = "public"
  auto_init              = true
  delete_branch_on_merge = true
  archived               = false
}

resource "github_repository" "archpi" {
  name = "archpi"

  description = "Repository containing ArchLinuxARM on Raspberry Pi 4 configurations https://archlinuxarm.org"

  visibility             = "public"
  auto_init              = true
  delete_branch_on_merge = true
}

resource "github_repository" "linux-startup-scaffolding" {
  name = "linux-startup-scaffolding"

  description = "Scaffolding for Linux initialization/dotfiles (shell, Xorg etc.)"

  auto_init              = true
  visibility             = "public"
  delete_branch_on_merge = true
  license_template       = "mit"
}

locals {
  repositories = { for repo in [
    github_repository.archpi,
    github_repository.build-vault-k8s-arm64,
    github_repository.buildah-arm64,
    github_repository.external-dns-arm64,
    github_repository.k3os-configs,
    github_repository.linux-startup-scaffolding,
    github_repository.nixpi,
    github_repository.nix-configs,
    github_repository.packer-rpi-k3s,
    github_repository.rpi-container-image-builder,
    github_repository.rpi4-k3os,
    github_repository.self,
    github_repository.terraform-provider-custom,
  ] : repo.name => repo }
}

resource "github_branch" "mains_to_masters" {
  for_each = {
    archpi = github_repository.archpi
  }

  repository = each.value.name
  branch     = "master"
}

resource "github_branch_protection" "masters" {
  for_each = local.repositories

  repository_id = each.value.name

  pattern = each.value.default_branch

  require_signed_commits = true
}
