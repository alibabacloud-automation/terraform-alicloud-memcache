variable "region" {
  default = "cn-shanghai"
}
provider "alicloud" {
  region = var.region
}
data "alicloud_vpcs" "default" {
  is_default = true
}
data "alicloud_vswitches" "default" {
  ids = [data.alicloud_vpcs.default.vpcs.0.vswitch_ids.0]
}
module "memcache_example" {
  source = "../../"
  region = var.region

  #################
  # Memcache Instance
  #################

  instance_name     = "myInstance"
  instance_class    = "memcache.logic.sharding.2g.8db.0rodb.8proxy.default"
  period            = 1
  vswitch_id        = data.alicloud_vpcs.default.vpcs.0.vswitch_ids.0
  availability_zone = data.alicloud_vswitches.default.vswitches.0.zone_id
  security_ips      = ["1.1.1.1", "2.2.2.2", "3.3.3.3"]
  private_ip        = "172.16.0.10"
  tags = {
    Env      = "Private"
    Location = "Secret"
  }

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