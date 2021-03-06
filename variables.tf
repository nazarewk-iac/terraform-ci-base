variable "gitlab_token" {
  type = string
}

variable "github_token" {
  type = string
}

variable "tfe_token" {
  type = string
}

variable "okta_token" {
  type = string
}


variable "gitlab_group" {
  type = string
}


variable "github_organization" {
  type = string
}


variable "tfe_organization_email" {
  type = string
}

variable "tfe_organization" {
  type = string
}


variable "okta_organization" {
  type = string
}

variable "okta_base_url" {
  type = string

  default = "okta.com"
}