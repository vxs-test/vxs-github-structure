# vxs-github-structure

## Run locally

    export TF_VAR_gh_token=
    make init
    make fmt
    make plan
    make apply

## Adding a team

    resource "github_team" "frontend" {
        name        = "frontend"
        description = "The frontend team"
        privacy     = "closed"
    }

## Adding a repo

    vxs-api = {
      description = "Maintained by backend, read by frontend"
      visibility  = "private"
      teams       = {
        (github_team.backend.id)  = "maintain"
        (github_team.frontend.id) = "pull"
      }
    }

## Adding a user

    stephanebruckert = {
      org_role = "member"
      teams    = {
        (github_team.backend.id) = "maintainer"
      }
    }
