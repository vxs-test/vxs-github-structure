terraform {
  cloud {
    organization = "vxs-test"
    workspaces {
      name = "vxs-github-structure"
    }
  }

  required_providers {
    github = {
      source  = "integrations/github"
      version = "6.0.0-rc2" # Using RC as it fixes https://github.com/integrations/terraform-provider-github/issues/769
    }
  }
}
