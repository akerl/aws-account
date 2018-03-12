module "publish-user" {
  source         = "../../modules/publish"
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
