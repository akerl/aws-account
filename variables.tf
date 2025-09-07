variable "admins" {
  type = set(string)
}

variable "billing_email" {
  type = string
}

variable "admin_email" {
  type = string
}

variable "domains" {
  type = set(string)
}

variable "backup_user" {
  type = string
}

variable "servers" {
  type = set(string)
}

variable "hub_records" {
  type = set(string)
}

variable "hass_records" {
  type = set(string)
}

variable "wg_records" {
  type = map(string)
}

variable "linode_aliases" {
  type = map(string)
}

variable "certificates" {
  type = map(list(string))
}
