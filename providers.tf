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
    tfe    = {
      source  = "hashicorp/tfe"
      version = "~> 0.26"
    }
    okta   = {
      source  = "okta/okta"
      version = "~> 3.19"
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

provider "okta" {
  org_name  = var.okta_organization
  base_url  = var.okta_base_url
  api_token = var.okta_token
}