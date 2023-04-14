terraform {
  required_providers {
    spectrocloud = {
      version = ">= 0.12"
      source  = "spectrocloud/spectrocloud"
    }
  }
}

variable "sc_host" {
  description = "Spectro Cloud Endpoint"
  default     = "api.spectrocloud.com"
}

variable "sc_api_key" {
  description = "Spectro API Key"
  sensitive   = true
}

variable "sc_project_name" {
  description = "Spectro Cloud Project (e.g: Default)"
  default     = "Default"
}

provider "spectrocloud" {
  host         = var.sc_host
  api_key      = var.sc_api_key
  project_name = var.sc_project_name
}
