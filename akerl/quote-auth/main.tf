module "github-auth" {
  source         = "github.com/akerl/terraform-aws-lambda-githubauth"
  logging-bucket = "${var.logging-bucket}"
  config-bucket  = "akerl-quote-auth"
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
