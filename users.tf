resource "github_membership" "org_membership" {
  username = "stephanebruckert"
  role     = "member"
}

resource "github_team_membership" "team_membership" {
  username = "stephanebruckert"
  role     = "maintainer"
  team_id  = github_team.backend.id

  depends_on = [github_membership.org_membership, github_team.backend]
}
