module "hookshot" {
  source         = "../../modules/hookshot"
  logging-bucket = "${var.logging-bucket}"
  data-bucket    = "dock0-arch"
  rate           = "1 hours"
}

variable "logging-bucket" {
  type = "string"
}
