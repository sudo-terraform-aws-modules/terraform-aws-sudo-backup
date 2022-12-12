# Terraform AWS SUDO Backup
AWS Terraform module for AWS Backup. The module will create a AWS Plan and selection criteria for supported AWS resources.

## Usage
Use this module to avoid re-writing and knowing alll the details of different parameters. Simply use the module without any paramters to configure AWS Backup with default settings.

The below example will configure AWS to backup all resources in your selected region with following tags.

```backup = true```

*Note:* There are no required input variables, Terraform registry has a bug which shows some variables as required.

Code Example:
```hcl
module "sudo-backup" {
  source  = "sudo-terraform-aws-modules/sudo-backup/aws"
  version = "1.0.0"
}
```

Copy in multiple Vaults Example for Disaster Ricovery Scenario:

Assuming you have second aws provider (useast2) defined for different region to create the vault.
```hcl
module "sudo-backup" {
  source  = "sudo-terraform-aws-modules/sudo-backup/aws"
  version = "1.0.2"
  secondary_vault_arn = module.dr-backup-vault.vault_arn
}

module "dr-backup-vault" {
  source  = "sudo-terraform-aws-modules/sudo-backup/aws"
  providers = {
    aws = aws.useast2
  }
}
```

## IAM Permissions Required

```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "Backup:CreateBackupPlan",
                "Backup:CreateBackupSelection",
                "Backup:DeleteBackupPlan",
                "Backup:DeleteBackupSelection",
                "Backup:GetBackupPlan",
                "Backup:GetBackupSelection",
                "Backup:ListTags",
                "Backup:TagResource",
                "Backup:UntagResource",
                "Backup:UpdateBackupPlan"
            ],
            "Resource": [
                "*"
            ]
        },
        {
            "Sid": "VisualEditor1",
            "Effect": "Allow",
            "Action": [
                "backup:CreateBackupVault",
                "backup:DeleteBackupVault",
                "backup:DescribeBackupVault",
                "backup:ListTags",
                "backup:TagResource",
                "backup:UntagResource"
            ],
            "Resource": [
                "*"
            ]
        },
        {
            "Sid": "VisualEditor2",
            "Effect": "Allow",
            "Action": [
                "backup-storage:MountCapsule"
            ],
            "Resource": [
                "*"
            ]
        },
        {
            "Sid": "VisualEditor3",
            "Effect": "Allow",
            "Action": [
                "ec2:DescribeAccountAttributes"
            ],
            "Resource": [
                "*"
            ]
        },
        {
            "Sid": "VisualEditor4",
            "Effect": "Allow",
            "Action": [
                "iam:AttachRolePolicy",
                "iam:CreateRole",
                "iam:DeleteRole",
                "iam:DetachRolePolicy",
                "iam:GetRole",
                "iam:ListAttachedRolePolicies",
                "iam:ListInstanceProfilesForRole",
                "iam:ListRolePolicies",
                "iam:PassRole"
            ],
            "Resource": [
                "*"
            ]
        },
        {
            "Sid": "VisualEditor5",
            "Effect": "Allow",
            "Action": [
                "kms:CreateGrant",
                "kms:CreateKey",
                "kms:Decrypt",
                "kms:DescribeKey",
                "kms:EnableKeyRotation",
                "kms:GenerateDataKey",
                "kms:GetKeyPolicy",
                "kms:GetKeyRotationStatus",
                "kms:ListResourceTags",
                "kms:RetireGrant",
                "kms:ScheduleKeyDeletion",
                "kms:TagResource",
                "kms:UntagResource"
            ],
            "Resource": [
                "*"
            ]
        }
    ]
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.1.3 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.13.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.1.3 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_backup_plan.plan](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/backup_plan) | resource |
| [aws_backup_selection.selection](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/backup_selection) | resource |
| [aws_backup_vault.vault](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/backup_vault) | resource |
| [aws_iam_role.iam_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.iam_role_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_kms_key.kms_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [random_string.random](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_backup_schedule"></a> [backup\_schedule](#input\_backup\_schedule) | (Optional) Backup schedule in cron format. Default: cron(0 12 * * ? *) | `string` | `"cron(0 12 * * ? *)"` | no |
| <a name="input_cold_storage_after"></a> [cold\_storage\_after](#input\_cold\_storage\_after) | (Optional) Specifies the number of days after creation that a recovery point is moved to cold storage. | `number` | `null` | no |
| <a name="input_delete_after"></a> [delete\_after](#input\_delete\_after) | (Optional) Specifies the number of days after creation that a recovery point is deleted. Must be 90 days greater than cold\_storage\_after | `number` | `null` | no |
| <a name="input_kms_key_arn"></a> [kms\_key\_arn](#input\_kms\_key\_arn) | (optional) Existing KMS Key ARN. Default: "" | `string` | `""` | no |
| <a name="input_name"></a> [name](#input\_name) | (Optional) Specify the name for the backup configuration. Default: sudo-backup-<randomstring> | `string` | `"sudo-backup"` | no |
| <a name="input_secondary_vault_arn"></a> [secondary\_vault\_arn](#input\_secondary\_vault\_arn) | (Optional) Specifies the ARN of the secondary vault for DR. | `string` | `null` | no |
| <a name="input_secondary_vault_cold_storage_after"></a> [secondary\_vault\_cold\_storage\_after](#input\_secondary\_vault\_cold\_storage\_after) | (Optional) Specifies the number of days after creation that a recovery point is moved to cold storage for Secondary Vault. Default uses the value from primary vault. | `number` | `null` | no |
| <a name="input_secondary_vault_delete_after"></a> [secondary\_vault\_delete\_after](#input\_secondary\_vault\_delete\_after) | (Optional) Specifies the number of days after creation that a recovery point is deleted for secondary Vault. Must be 90 days greater than cold\_storage\_after. Default uses the value from primary vault. | `number` | `null` | no |
| <a name="input_selection_tags"></a> [selection\_tags](#input\_selection\_tags) | (Optional) List of objects containing tag key value and type (comparison operator). | `list(any)` | <pre>[<br>  {}<br>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_iam_role_arn"></a> [iam\_role\_arn](#output\_iam\_role\_arn) | ARN of the IAM role created for Backup |
| <a name="output_kms_key_arn"></a> [kms\_key\_arn](#output\_kms\_key\_arn) | ARN of the KMS Key if created, otherwise null |
| <a name="output_plan_arn"></a> [plan\_arn](#output\_plan\_arn) | ARN of the Backup Plan |
| <a name="output_vault_arn"></a> [vault\_arn](#output\_vault\_arn) | ARN of the backup vault. |
<!-- END_TF_DOCS -->
