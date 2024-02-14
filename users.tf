locals {
  user_to_team = {
    stephanebruckert = {
      org_role = "member"
      teams = {
        (github_team.backend.id) = "maintainer"
      }
    }
  }
}

module "user" {
  source   = "./modules/user"
  for_each = local.user_to_team
  username = each.key
  org_role = each.value.org_role
  teams    = each.value.teams
}
