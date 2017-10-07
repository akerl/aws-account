variable "logging-bucket" {
  type = "string"
}

variable "file-bucket" {
  type = "string"
}

variable "redirect-bucket" {
  type = "string"
}

variable "write-user" {
  type = "string"
}

variable "root-domain" {
  type = "string"
}

variable "redirect-domains" {
  type    = "list"
  default = []
}

variable "no-cache-path" {
  type    = "string"
  default = "_________"
}
