module "s3authproxy" {
  source         = "github.com/armorfret/terraform-aws-lambda-s3authproxy"
  logging-bucket = "${var.logging-bucket}"
  config-bucket  = "akerl-private-files-config"
  data-bucket    = "akerl-private-files"
  lambda-bucket  = "${var.lambda-bucket}"
  domain         = "files.scrtybybscrty.org"
  version        = "${chomp(file("${path.module}/../../versions/madlibrarian-lambda"))}"
}

variable "logging-bucket" {
  type = "string"
}

variable "lambda-bucket" {
  type = "string"
}

output "dns-name" {
  value = "${module.s3authproxy.dns-name}"
}
