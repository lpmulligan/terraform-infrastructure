variable "location" {}

variable "prefix" {}

variable "address_space" {
  default = ["10.13.0.0/20"]
}

variable "address_prefix" {
  default = "10.13.8.0/22"
}

variable "address_prefix_aci" {
  default = "10.13.12.0/22"
}

variable "min_count" {
  default = 1
}
variable "max_count" {
  default = 3
}

variable "vm_size" {
  default = "Standard_D2_v2"
}

variable "windows_enabled" {
  default = false
}

variable "min_count_windows" {
  default = 1
}
variable "max_count_windows" {
  default = 3
}
variable "vm_size_windows" {
  default = "Standard_D2_v2"
}

variable "monitor_email" {}

variable "tags" {
  default = {}
}