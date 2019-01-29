variable "logging-bucket" {
  type = "string"
}

variable "data-bucket" {
  type    = "string"
  default = "akerl-hellolinodians-config"
}

variable "lambda-bucket" {
  type    = "string"
  default = "akerl-go-hello-linodians"
}

variable "rate" {
  type    = "string"
  default = "1 hour"
}

module "publish-user" {
  source         = "github.com/akerl/terraform-aws-s3-publish"
  logging-bucket = "${var.logging-bucket}"
  publish-bucket = "${var.lambda-bucket}"
}

module "hellolinodians" {
  source         = "github.com/armorfret/terraform-aws-lambda-hellolinodians"
  logging-bucket = "${var.logging-bucket}"
  data-bucket    = "${var.data-bucket}"
  rate           = "${var.rate}"
  version        = "${chomp(file("${path.module}/../../versions/go-hello-linodians"))}"
}
