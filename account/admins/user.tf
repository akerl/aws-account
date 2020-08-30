terraform {
  required_providers {
    aws = {
      version = "3.4.0"
    }

    awscreds = {
      source  = "terraform.scrtybybscrty.org/armorfret/awscreds"
      version = "0.2.0"
    }
  }
}

variable "admins" {
  type = list(string)
}

resource "aws_iam_user" "admins" {
  name  = var.admins[count.index]
  count = length(var.admins)
}

resource "aws_iam_group_membership" "admins" {
  name       = "admins"
  users      = var.admins
  group      = aws_iam_group.admins.name
  depends_on = [aws_iam_user.admins]
}

resource "awscreds_iam_access_key" "admins" {
  user       = var.admins[count.index]
  file       = "creds/account-admins-${var.admins[count.index]}"
  count      = length(var.admins)
  depends_on = [aws_iam_user.admins]
}

