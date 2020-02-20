output "self_github_repo_url" {
  value = github_repository.self.git_clone_url
}

output "self_gitlab_repo_url" {
  value = gitlab_project.self.ssh_url_to_repo
}
