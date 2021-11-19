resource "tfe_organization" "self" {
  email = var.tfe_organization_email
  name  = var.tfe_organization
}

resource "tfe_workspace" "self" {
  name         = replace(local.self-name, "/^terraform-/", "")
  organization = tfe_organization.self.id
  terraform_version = "1.0.11"

  auto_apply = false

  vcs_repo {
    identifier     = format("%s/%s", var.github_organization, github_repository.self.id)
    oauth_token_id = tfe_oauth_client.self-github.oauth_token_id
  }
}

resource "tfe_oauth_client" "self-gitlab" {
  organization     = tfe_organization.self.name
  api_url          = "https://gitlab.com/api/v4"
  http_url         = "https://gitlab.com"
  oauth_token      = var.gitlab_token
  service_provider = "gitlab_hosted"
}

resource "tfe_oauth_client" "self-github" {
  organization     = tfe_organization.self.name
  api_url          = "https://api.github.com"
  http_url         = "https://github.com"
  oauth_token      = var.github_token
  service_provider = "github"
}
