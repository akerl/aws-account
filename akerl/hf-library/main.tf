module "madlibrarian" {
  source         = "../../modules/madlibrarian"
  logging-bucket = "${var.logging-bucket}"
  config-bucket  = "akerl-hf-library-config"
  data-bucket    = "akerl-hf-library"
  lambda-bucket  = "${var.lambda-bucket}"
  domain         = "hf.coolquotes.xyz"
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
