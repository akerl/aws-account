module "madlibrarian" {
  source         = "../../modules/madlibrarian"
  logging-bucket = "${var.logging-bucket}"
  config-bucket  = "akerl-book-library-config"
  data-bucket    = "akerl-book-library"
  lambda-bucket  = "${var.lambda-bucket}"
  domain         = "books.coolquotes.xyz"
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
