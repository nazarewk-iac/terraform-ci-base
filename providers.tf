provider "gitlab" {
  token = var.gitlab_token
}

provider "github" {
  organization = var.github_organization
  token        = var.github_token
}

provider "tfe" {
  token = var.tfe_token
}

provider "okta" {
  org_name  = var.okta_organization
  base_url  = var.okta_base_url
  api_token = var.okta_token
}