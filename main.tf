locals {
  #instance
  this_instance_id      = var.existing_instance_id != "" ? var.existing_instance_id : concat(alicloud_kvstore_instance.this.*.id, [""])[0]
  create_more_resources = var.existing_instance_id != "" || var.create_instance ? true : false
  instance_type         = "Memcache"
  engine_version        = "4.0"
  project               = "acs_memcache"
}

resource "alicloud_kvstore_instance" "this" {
  count               = var.create_instance ? 1 : 0
  instance_type       = local.instance_type
  engine_version      = local.engine_version
  db_instance_name    = var.instance_name
  instance_class      = var.instance_class
  vswitch_id          = var.vswitch_id
  zone_id             = var.availability_zone
  security_ips        = var.security_ips
  payment_type        = var.instance_charge_type
  period              = var.period
  auto_renew          = var.auto_renew
  auto_renew_period   = var.auto_renew_period
  private_ip          = var.private_ip
  backup_id           = var.instance_backup_id
  maintain_start_time = var.maintain_start_time
  maintain_end_time   = var.maintain_end_time
  tags                = var.tags
}

resource "alicloud_kvstore_backup_policy" "this" {
  count         = var.create_instance ? 1 : 0
  instance_id   = local.this_instance_id
  backup_period = var.backup_policy_backup_period
  backup_time   = var.backup_policy_backup_time
}

resource "alicloud_cms_alarm" "cpu_usage" {
  count   = var.enable_alarm_rule ? 1 : 0
  enabled = var.enable_alarm_rule
  name    = var.alarm_rule_name
  project = local.project
  metric  = "CpuUsage"
  dimensions = {
    instanceId = local.this_instance_id
    device     = "/dev/vda1,/dev/vdb1"
  }
  escalations_critical {
    statistics          = var.alarm_rule_statistics
    comparison_operator = var.alarm_rule_operator
    threshold           = var.alarm_rule_threshold
    times               = var.alarm_rule_triggered_count
  }
  period             = var.alarm_rule_period
  contact_groups     = var.alarm_rule_contact_groups
  silence_time       = var.alarm_rule_silence_time
  effective_interval = var.alarm_rule_effective_interval
}

resource "alicloud_cms_alarm" "memory_usage" {
  count   = var.enable_alarm_rule ? 1 : 0
  enabled = var.enable_alarm_rule
  name    = var.alarm_rule_name
  project = local.project
  metric  = "MemoryUsage"
  dimensions = {
    instanceId = local.this_instance_id
    device     = "/dev/vda1,/dev/vdb1"
  }
  escalations_critical {
    statistics          = var.alarm_rule_statistics
    comparison_operator = var.alarm_rule_operator
    threshold           = var.alarm_rule_threshold
    times               = var.alarm_rule_triggered_count
  }
  period             = var.alarm_rule_period
  contact_groups     = var.alarm_rule_contact_groups
  silence_time       = var.alarm_rule_silence_time
  effective_interval = var.alarm_rule_effective_interval
}

resource "alicloud_cms_alarm" "used_connection" {
  count   = var.enable_alarm_rule ? 1 : 0
  enabled = var.enable_alarm_rule
  name    = var.alarm_rule_name
  project = local.project
  metric  = "UsedConnection"
  dimensions = {
    instanceId = local.this_instance_id
    device     = "/dev/vda1,/dev/vdb1"
  }
  escalations_critical {
    statistics          = var.alarm_rule_statistics
    comparison_operator = var.alarm_rule_operator
    threshold           = var.alarm_rule_threshold
    times               = var.alarm_rule_triggered_count
  }
  period             = var.alarm_rule_period
  contact_groups     = var.alarm_rule_contact_groups
  silence_time       = var.alarm_rule_silence_time
  effective_interval = var.alarm_rule_effective_interval
}