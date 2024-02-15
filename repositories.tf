locals {
  repos_to_teams = {
    vxs-github-structure = {
      description     = "Should be private but made public for gh actions to fetch secrets in a free org"
      visibility      = "public"
      has_projects    = true
      has_issues      = true
      has_discussions = true
      has_wiki        = true
      teams           = {}
    }
    vxs-api = {
      description     = "Maintained by backend, read by frontend"
      visibility      = "private"
      has_projects    = true
      has_issues      = false
      has_discussions = true
      has_wiki        = false

      teams = {
        (github_team.backend.id)  = "maintain"
        (github_team.frontend.id) = "pull"
      }
    }
    vxs-ui = {
      description     = "Maintained by frontend, read by frontend"
      visibility      = "private"
      has_projects    = true
      has_issues      = false
      has_discussions = true
      has_wiki        = false
      teams = {
        (github_team.frontend.id) = "maintain"
      }
    }
    vxs-sdk = {
      description     = "Written by frontend and backend"
      visibility      = "public"
      has_projects    = false
      has_issues      = true
      has_discussions = true
      has_wiki        = true
      teams = {
        (github_team.backend.id)  = "push"
        (github_team.frontend.id) = "push"
      }
    }
  }
}

module "repository" {
  source          = "./modules/repository"
  for_each        = local.repos_to_teams
  name            = each.key
  description     = each.value.description
  visibility      = each.value.visibility
  teams           = each.value.teams
  has_issues      = each.value.has_issues
  has_projects    = each.value.has_projects
  has_discussions = each.value.has_discussions
  has_wiki        = each.value.has_wiki
}
