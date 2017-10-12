variable "admins" {
  type = "list"
}

module "admins" {
  source = "./admins"
  admins = ["${var.admins}"]
}
