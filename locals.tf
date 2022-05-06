locals {
  create_kms_key = var.kms_key_arn == "" ? true : false
  kms_key_arn    = coalesce(var.kms_key_arn, resource.aws_kms_key.arn)

  name = var.name == "sudo-backup" ? "sudo-backup-${random_sting.random.result}" : var.name
}

resource "random_string" "random" {
  length           = 6
  special          = false
}
