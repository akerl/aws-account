variable "admins" {
  type = list(string)
}

module "admins" {
  source = "./admins"
  admins = var.admins
}

