resource "tfe_organization" "self" {
  email = var.tfe_organization_email
  name  = var.tfe_organization
}

resource "tfe_workspace" "self" {
  name         = replace(local.self-name, "/^terraform-/", "")
  organization = tfe_organization.self.id

  lifecycle {
    ignore_changes = [
      vcs_repo,
    ]
  }
}

resource "tfe_oauth_client" "self-gitlab" {
  organization     = tfe_organization.self.name
  api_url          = "https://gitlab.com/api/v4"
  http_url         = "https://gitlab.com"
  oauth_token      = var.gitlab_token
  service_provider = "gitlab"
}

resource "tfe_oauth_client" "self-github" {
  organization     = tfe_organization.self.name
  api_url          = "https://api.github.com"
  http_url         = "https://github.com"
  oauth_token      = var.github_token
  service_provider = "github"
}
