variable "cluster_name" {
  type = string
}

variable "kubeconfig" {
  type = string
}

variable "username" {
  type = string
  default = "jgeissler14"
}

variable "adminPassword" {
  type = string
  default = "password"
}