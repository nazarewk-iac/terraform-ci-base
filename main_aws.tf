resource "github_repository" "aws-organization" {
  name = "aws-organization"

  description = "Repository containing configuration of AWS Organization"

  visibility             = "public"
  auto_init              = true
  delete_branch_on_merge = true
}

resource "tfe_workspace" "aws-nazarewk-management" {
  name              = "aws-nazarewk-management"
  organization      = tfe_organization.self.id
  terraform_version = "1.0.11"

  auto_apply          = false
  global_remote_state = false
  queue_all_runs      = false

  vcs_repo {
    identifier     = format("%s/%s", var.github_organization, github_repository.aws-organization.id)
    oauth_token_id = tfe_oauth_client.self-github.oauth_token_id
  }
}

resource "github_repository" "eks-app-demo" {
  name = "eks-app-demo"

  description = "Repository demonstrating usage of EKS, PostgreSQL & SQS"

  visibility             = "public"
  auto_init              = true
  delete_branch_on_merge = true
}