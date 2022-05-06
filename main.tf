
resource "aws_kms_key" "" {
  count               = local.create_kms_key ? 1 : 0
  description         = "KMS key for Backup Encryption at rest"
  enable_key_rotation = true

  tags = {
    Name = "${var.name}-backup-encryption-key"
  }
}

resource "aws_backup_vault" "vault" {
  name        = "${var.name}-backup-vault "
  kms_key_arn = local.kms_key_arn
  tags = {
    Name = "${var.name}-backup-vault"
  }
}


resource "aws_backup_plan" "plan" {
  name = "plan-${var.name}-backup-plan"
  tags = {
    Name = "${var.name}-backup-plan"
  }

  rule {
    rule_name         = "${var.name}-backup-rule"
    target_vault_name = aws_backup_vault.vault.name
    schedule          = var.backup_schedule


    lifecycle {
      cold_storage_after = var.rule_lifecycle_cold_storage_after
      delete_after       = var.rule_lifecycle_delete_after
    }

    recovery_point_tags = {
      Name = "${var.name}-backup-recovery-point"
    }

  }
}



resource "aws_backup_selection" "selection" {
  name         = "selection-${var.name}-backup"
  iam_role_arn = aws_iam_role.backup_role.arn

  plan_id = aws_backup_plan.backup_plan.id

  selection_tag {
    type  = var.selection_tag_type
    key   = var.selection_tag_key
    value = var.selection_tag_value
  }
}
