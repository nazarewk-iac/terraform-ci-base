resource "tfe_organization" "self" {
  email = var.tfe_organization_email
  name  = var.tfe_organization
}

resource "tfe_workspace" "self" {
  name         = replace(local.self-name, "/^terraform-/", "")
  organization = tfe_organization.self.id
}
