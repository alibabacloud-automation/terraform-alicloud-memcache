variable "region" {
  default = "cn-shanghai"
}
provider "alicloud" {
  region = var.region
}
module "memcache_example" {
  source = "../../"
  region = var.region

  #################
  # Memcache Instance
  #################

  existing_instance_id = "m-uf65086bb8xxxxxx"

  #################
  # Memcache backup_policy
  #################

  backup_policy_backup_time   = "02:00Z-03:00Z"
  backup_policy_backup_period = ["Monday", "Wednesday", "Friday"]

  #############
  # cms_alarm
  #############

  alarm_rule_name            = "CmsAlarmForMemcache"
  alarm_rule_statistics      = "Average"
  alarm_rule_period          = 300
  alarm_rule_operator        = "<="
  alarm_rule_threshold       = 35
  alarm_rule_triggered_count = 2
  alarm_rule_contact_groups  = ["AccCms"]
}