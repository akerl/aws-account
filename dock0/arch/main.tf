module "hookshot" {
  source         = "github.com/armorfret/terraform-aws-lambda-hookshot"
  logging-bucket = "${var.logging-bucket}"
  data-bucket    = "dock0-arch"
  rate           = "1 hour"
  version        = "${chomp(file("${path.module}/../../versions/hookshot"))}"
}

variable "logging-bucket" {
  type = "string"
}
