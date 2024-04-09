terraform {
  required_providers {
    gitlab = {
      source  = "gitlabhq/gitlab"
      version = "~> 3.8"
    }
    github = {
      source  = "integrations/github"
      version = "~> 4.18"
    }
    tfe = {
      source  = "hashicorp/tfe"
      version = "~> 0.26"
    }
  }
}

provider "gitlab" {
  token = var.gitlab_token
}

provider "github" {
  owner = var.github_organization
  token = var.github_token
}

provider "tfe" {
  token = var.tfe_token
}