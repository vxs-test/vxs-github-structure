# vxs-github-structure

For consistency all org users, repositories and teams must be created in this repo.

## Contribute

### Adding a team

In [teams.tf](./teams.tf), add a `github_team` resource:

    resource "github_team" "frontend" {
        name        = "frontend"
        description = "The frontend team"
        privacy     = "closed"
    }

### Adding a repo

In [repositories.tf](./repositories.tf), update `local.repos_to_teams`:

    vxs-api = {
      description     = "Maintained by backend, read by frontend"
      visibility      = "private"
      has_projects    = false
      has_issues      = true
      has_discussions = true
      has_wiki        = true
      teams           = {
        (github_team.backend.id)  = "maintain"
        (github_team.frontend.id) = "pull"
      }
    }

### Adding a user

In [users.tf](./users.tf), update `local.users_to_teams`:

    stephanebruckert = {
      org_role = "member"
      teams    = {
        (github_team.backend.id) = "maintainer"
      }
    }

## Run

### Via GHA

 - pushing will automatically run the plan
 - applying is manual via [`Run Workflow`](https://github.com/vxs-test/vxs-github-structure/actions/workflows/apply.yaml) button 

### Locally (only for development)

    export TF_VAR_gh_token=<GITHUB_FINE_GRAINED_PERSONAL_ACCESS_TOKEN>
    terraform login
    terraform init
    terraform plan
    terraform apply
    terraform fmt -recursive -diff

## Org settings

The github org should have the following settings set manually.
In ["Org settings" -> "member privileges"](https://github.com/organizations/vxs-test/settings/member_privileges):
   - Base permissions:
     - set "no permission" so users without teams can't access existing repositories
   - Repository creation:
     - disable "public" and "private" so users can't manually create new repositories

## State file

Stored in Terraform Cloud under `vxs-test` project and `vxs-github-structure` workspace.

## Caveats

- this service can have destructive impacts, as a maintainer always check the TF plan before running TF apply
- adding existing resources in here will require them to be added to the state using `terraform import`
- using a Github secret in GHA actions under a free org requires the (current) repo to be public
  - https://docs.github.com/en/actions/security-guides/using-secrets-in-github-actions#creating-secrets-for-an-organization
- currently using RC version 6.0.0-rc2 of the GH provider as it fixes https://github.com/integrations/terraform-provider-github/issues/769
- using Github beta feature "fine-grained personal access tokens" as it allows creating personal access 
  tokens for an org rather than personal repositories, which means no need to create an admin user bot
  - https://github.blog/2022-10-18-introducing-fine-grained-personal-access-tokens-for-github/
- what happens if a user doesn't accept an invite in time?
- investigate: `has_projects`, `has_issues`, `has_discussions`, `has_wiki` implemented but don't seem to take effect
- fix: new team must be added independently from user or repo membership

## Current structure

![current structure](https://github.com/vxs-test/vxs-github-structure/assets/1932338/5869efc8-8b40-44d7-af30-9d90e91e81fc)
