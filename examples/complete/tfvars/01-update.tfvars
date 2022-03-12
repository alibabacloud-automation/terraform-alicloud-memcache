# Memcache instance
instance_name       = "update-tf-testacc-name"
security_ips        = ["10.23.12.24"]
period              = 2
auto_renew          = true
auto_renew_period   = 2
maintain_start_time = "00:00Z"
maintain_end_time   = "01:00Z"
tags = {
  Name = "UpdateMemcache"
}

# Memcache backup_policy
backup_policy_backup_period = ["Tuesday"]
backup_policy_backup_time   = "00:00Z-01:00Z"

# cms_alarm
enable_alarm_rule             = false
alarm_rule_name               = "update-tf-testacc-alarm-rule-name"
alarm_rule_statistics         = "Maximum"
alarm_rule_operator           = "<="
alarm_rule_threshold          = "35"
alarm_rule_triggered_count    = "5"
alarm_rule_period             = "900"
alarm_rule_silence_time       = 10000
alarm_rule_effective_interval = "1:00-3:00"