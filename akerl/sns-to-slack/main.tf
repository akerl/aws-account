module "publish-user" {
  source         = "github.com/armorfret/terraform-aws-s3-publish"
  logging-bucket = "${var.logging-bucket}"
  publish-bucket = "${var.data-bucket}"
}

variable "logging-bucket" {
  type = "string"
}

variable "data-bucket" {
  type    = "string"
  default = "akerl-sns-to-slack"
}
