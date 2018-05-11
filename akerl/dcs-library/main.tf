module "madlibrarian" {
  source         = "../../modules/madlibrarian"
  logging-bucket = "${var.logging-bucket}"
  config-bucket  = "akerl-dcs-library-config"
  data-bucket    = "akerl-dcs-library"
  lambda-bucket  = "${var.lambda-bucket}"
  domain         = "dcs.coolquotes.xyz"
}

variable "logging-bucket" {
  type = "string"
}

variable "lambda-bucket" {
  type = "string"
}

output "dns-name" {
  value = "${module.madlibrarian.dns-name}"
}
