module "hookshot" {
  source         = "../../modules/hookshot"
  logging-bucket = "${var.logging-bucket}"
  data-bucket    = "dock0-arch"
  rate           = "5 minutes"
}

variable "logging-bucket" {
  type = "string"
}
