resource "github_repository" "repo" {
  name        = var.name
  description = var.description
  visibility  = var.visibility
}

resource "github_team_repository" "team_repo" {
  for_each   = var.teams
  team_id    = each.key
  permission = each.value
  repository = var.name

  depends_on = [github_repository.repo]
}
