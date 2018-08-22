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
