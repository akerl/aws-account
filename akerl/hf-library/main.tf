module "madlibrarian" {
  source         = "github.com/armorfret/terraform-aws-lambda-madlibrarian"
  logging-bucket = "${var.logging-bucket}"
  config-bucket  = "akerl-hf-library-config"
  data-bucket    = "akerl-hf-library"
  lambda-bucket  = "${var.lambda-bucket}"
  domain         = "hf.coolquotes.xyz"
  version        = "${chomp(file("${path.module}/../../versions/madlibrarian-lambda"))}"
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
