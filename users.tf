locals {
  users_to_teams = {
    stephanebruckert = {
      org_role = "member"
      teams = {
#        (github_team.backend.id) = "maintainer"
      }
    }
  }
}

module "user" {
  source   = "./modules/user"
  for_each = local.users_to_teams
  username = each.key
  org_role = each.value.org_role
  teams    = each.value.teams
}
