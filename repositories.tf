locals {
  repos_to_teams = {
    vxs-github-structure = {
      description = "Should be private but made public for gh actions to fetch secrets in a free org"
      visibility  = "public"
      teams       = {}
    }
    vxs-api = {
      description = "Maintained by backend, read by frontend"
      visibility  = "private"
      teams = {
        (github_team.backend.id)  = "maintain"
        (github_team.frontend.id) = "pull"
      }
    }
    vxs-ui = {
      description = "Maintained by frontend, read by frontend"
      visibility  = "private"
      teams = {
        (github_team.frontend.id) = "maintain"
      }
    }
    vxs-sdk = {
      description = "Written by frontend and backend"
      visibility  = "public"
      teams = {
        (github_team.backend.id)  = "push"
        (github_team.frontend.id) = "push"
      }
    }
  }
}

module "repository" {
  source      = "./modules/repository"
  for_each    = local.repos_to_teams
  name        = each.key
  description = each.value.description
  visibility  = each.value.visibility
  teams       = each.value.teams
}
