resource "github_team" "backend" {
  name        = "backend"
  description = "The backend team"
  privacy     = "closed"
}

resource "github_team" "frontend" {
  name        = "frontend"
  description = "The frontend team"
  privacy     = "closed"
}
