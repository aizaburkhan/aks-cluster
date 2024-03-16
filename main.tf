
resource "random_pet" "team1" {}

provider "azurerm" {
  features {}
  skip_provider_registration = true
}

resource "azurerm_resource_group" "project" {
  name     = "${random_pet.team1.id}-rg"
  location = "East US 2"

  tags = {
    environment = "project AKS"
  }
}

resource "azurerm_kubernetes_cluster" "project" {
  name                = "${random_pet.team1.id}-aks"
  location            = azurerm_resource_group.project.location
  resource_group_name = azurerm_resource_group.project.name
  dns_prefix          = "${random_pet.team1.id}-k8s"
  kubernetes_version  = "1.29.0"

  default_node_pool {
    name            = "default"
    node_count      = 2
    vm_size         = "Standard_D2_v2"
    os_disk_size_gb = 30
  }

  # addon_profile {
  #   http_application_routing {
  #   enabled = true
  #   }
  # }
  service_principal {
    client_id     = var.appId
    client_secret = var.password
  }

  role_based_access_control_enabled = true

  tags = {
    environment = "project AKS"
  }
}
resource "azurerm_kubernetes_cluster_node_pool" "mem" {
  kubernetes_cluster_id = azurerm_kubernetes_cluster.project.id
  name                  = "mem"
  node_count            = "1"
  vm_size               = "standard_d11_v2"
}

