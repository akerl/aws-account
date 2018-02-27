module "publish-user" {
  source         = "../../modules/publish"
  logging-bucket = "${var.logging-bucket}"
  publish-bucket = "${var.data-bucket}"
}
