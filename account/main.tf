variable "admins" {
  type = list(string)
}

variable "billing_email" {
  type = string
}

module "admins" {
  source = "./admins"
  admins = var.admins
}

