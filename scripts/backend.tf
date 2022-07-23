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
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.46.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "tfstate"
    storage_account_name = "seotubeterraform"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }

}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "state-demo-secure" {
  name     = "state-demo"
  location = "eastus"
}
