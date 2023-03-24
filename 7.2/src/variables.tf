###cloud vars
variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network & subnet name"
}


###ssh vars

variable "vms_ssh_root_key" {
  type        = string
  default     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC98WcIWyNYxHuXDcL9/HWvd+Oy570VZx2cBzYL4z9HGLNMwVAxcdPjottkEYEBPa0ew+ZjzpMlDB171/o67R58+X4MPEiJlJeShAillW6EcWs1eb7e8D0sE+jGcuYCk+owyldJYCJOtkFWpMFjZ9MhBkLzwghVa+X03Gq/0pParx5OWElS32MtvhTlTehAdFU5UY6ym1Ueh4CXwfNE3v+PAHcG6f+EDIwZQsdeY5ApMpmP5hDj2y6EQhOoBCXnL0PITaJ+LGwnpAaPB4o4zn/1O/WeUC+cFoSPl83qSrzjMWGCrI/n+TlMMWJxv6nJTtZsIyieQaDkhA6M92lSUK9uKVlCAQjsBiwcP5o84fSsYbj2OT43HscBVmysfcIameIWO6ex7x2s5jsrBCK6ib4aqnXPIUoL8TfdFFoNmVzcLJzG5jJr8nQGQONRniygb7OnhT7A7c6by6Mgu0s/P2F2k+vlFPGgD/tpR+ja2DuLJMruMtxudgpINjdzvBNttrc= s3a1@s3a1-virtual-machine"
  description = "ssh-keygen -t ed25519"
}
