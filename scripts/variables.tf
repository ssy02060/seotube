# Sets global variables for this Terraform project.

variable "app_name" {
  default = "seotube"
}
variable "location" {
  default = "Korea Central"
}

variable "admin_username" {
  default = "seo"
}

variable "app_version" { # Can't be called version! That's a reserved word.
  default = "latest"
}

variable "client_id" {

}

variable "client_secret" {

}

variable storage_account_name {
}

variable storage_access_key {
}
