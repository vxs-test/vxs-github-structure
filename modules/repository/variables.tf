variable "name" {
  type = string
}
variable "description" {
  type = string
}
variable "visibility" {
  type = string
}
variable "has_issues" {
  type    = bool
}
variable "has_projects" {
  type    = bool
}
variable "has_discussions" {
  type    = bool
}
variable "has_wiki" {
  type    = bool
}

variable "teams" {}
