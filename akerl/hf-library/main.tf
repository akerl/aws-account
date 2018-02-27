module "madlibrarian" {
  source = "../../modules/madlibrarian"
  logging-bucket  = "${var.logging-bucket}"
  data-bucket = "akerl-hf-library"
  lambda-bucket = "${var.lambda-bucket}"
  domain = "hftest.coolquotes.xyz"
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
