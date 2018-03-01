module "github-auth" {
  source         = "../../modules/github-auth"
  logging-bucket = "${var.logging-bucket}"
  data-bucket    = "akerl-quote-auth"
  lambda-bucket  = "${var.lambda-bucket}"
  domain         = "auth.coolquotes.xyz"
}

variable "logging-bucket" {
  type = "string"
}

variable "lambda-bucket" {
  type = "string"
}

output "dns-name" {
  value = "${module.github-auth.dns-name}"
}
