variable "name" {
  type        = string
  description = "(Optional) Specify the name for the backup configuration. Default: sudo-backup-<randomstring>"
  default     = "sudo-backup"
}


variable "backup_schedule" {
  type        = string
  description = "(Optional) Backup schedule in cron format. Default: cron(0 12 * * ? *)"
  default     = "cron(0 12 * * ? *)" # Take backup at UTC 12noon i.e 4am PST
}

variable "kms_key_arn" {
  type        = string
  description = "(optional) Existing KMS Key ARN. Default: \"\""
  default     = ""
}