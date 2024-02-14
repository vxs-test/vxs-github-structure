resource "github_membership" "org_membership" {
  username = var.username
  role     = var.org_role
}

resource "github_team_membership" "team_membership" {
  for_each = var.teams
  team_id  = each.key
  role     = each.value
  username = var.username

  depends_on = [github_membership.org_membership]
}
