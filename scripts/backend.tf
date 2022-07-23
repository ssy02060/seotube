# # Sets the "backend" used to store Terraform state.
# # This is required to make continous delivery work.

# terraform {
#   backend "azurerm" {
#     resource_group_name  = "seotube"
#     storage_account_name = "seotubeterraform"
#     container_name       = "terraform-state"
#     key                  = "terraform.tfstate"
#   }
# }
terraform {
  backend "azurerm" {
    resource_group_name  = "seotube-test"
    storage_account_name = "seotubeterraform"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}
