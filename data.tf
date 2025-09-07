data "terraform_remote_state" "linode" {
  backend = "http"
  config = {
    address = "https://raw.githubusercontent.com/akerl/linode-account/main/terraform.tfstate"
  }
}

data "terraform_remote_state" "unifi" {
  backend = "http"
  config = {
    address = "https://raw.githubusercontent.com/akerl/unifi-site/main/terraform.tfstate"
  }
}
