terraform {
  backend "remote" {
    organization = "nazarewk-iac"

    workspaces {
      name = "ci-base"
    }
  }
}
