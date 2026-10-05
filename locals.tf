locals {
  create_kms_key = var.kms_key_arn == ""
  kms_key_arn    = var.kms_key_arn != "" ? var.kms_key_arn : aws_kms_key.kms_key[0].arn

  name = var.name == "sudo-backup" ? "sudo-backup-${random_string.random.result}" : var.name

  secondary_vault_cold_storage_after = var.secondary_vault_cold_storage_after != null ? var.secondary_vault_cold_storage_after : var.cold_storage_after
  secondary_vault_delete_after       = var.secondary_vault_delete_after != null ? var.secondary_vault_delete_after : var.delete_after

}

resource "random_string" "random" {
  length  = 6
  special = false
  upper   = false
}
