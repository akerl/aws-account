module "hookshot" {
  source         = "github.com/akerl/terraform-aws-lambda-hookshot"
  logging-bucket = "${var.logging-bucket}"
  data-bucket    = "dock0-arch"
  rate           = "1 hour"
}

variable "logging-bucket" {
  type = "string"
}
