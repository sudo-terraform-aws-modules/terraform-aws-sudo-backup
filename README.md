# Terraform AWS SUDO Backup
AWS Terraform module for AWS Backup. The module will create a AWS Plan and selection criteria for supported AWS resources.

## Usage
Use this module to avoid re-writing and knowing alll the details of different parameters. Simply use the module without any paramters to configure AWS Backup with default settings.

The below example will configure AWS to backup all resources in your selected region with following tags.

```backup = true```

Code Example:
```hcl
module "aws_backup" {
  source = "https://github.com/sudo-terraform-aws-modules/terraform-aws-sudo-backup.git"
}
```
