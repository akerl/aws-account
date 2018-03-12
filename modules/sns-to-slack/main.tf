variable "logging-bucket" {
  type = "string"
}

variable "topic" {
  type = "string"
}

variable "config-bucket" {
  type = "string"
}

variable "lambda-bucket" {
  type = "string"
  default = "akerl-sns-to-slack"
}

output "sns-topic-arn" {
  value = "${aws_sns_topic.topic.arn}"
}
