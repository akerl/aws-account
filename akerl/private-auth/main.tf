module "github-auth" {
  source         = "github.com/armorfret/terraform-aws-lambda-githubauth"
  logging-bucket = "${var.logging-bucket}"
  config-bucket  = "akerl-private-auth"
  lambda-bucket  = "${var.lambda-bucket}"
  domain         = "auth.scrtybybscrty.org"
  version        = "${chomp(file("${path.module}/../../versions/github-auth-lambda"))}"
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
