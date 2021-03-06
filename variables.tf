variable "project_name" {
  description = "Name for your testing project. [lowercase, cannot contain spaces]"
  type        = string
  default     = "gw"
}

variable "datacenter" {
  description = "Datacenter Zone where worker and master nodes will be deployed."
  type        = string
  default     = "dal12"
}

variable "machine_flavor" {
  description = "The default machine profile"
  type        = string
  default     = "b3c.8x32"
}


variable "hardware_type" {
  description = "The hardware isolation type. In this case worker nodes reside on Public VSIs."
  type        = string
  default     = "shared"
}

variable "iaas_classic_username" {
  description = "IBM Cloud IaaS Username."
  type        = string
  default     = ""
}

variable "iaas_classic_api_key" {
  description = "IBM Cloud IaaS User API key."
  type        = string
  default     = ""
}

variable "resource_group" {
  description = "Resource group for resources."
  type        = string
  default     = ""
}
