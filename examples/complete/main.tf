data "alicloud_kvstore_zones" "default" {
  engine = "Memcache"
}

data "alicloud_kvstore_instance_classes" "default" {
  engine  = "Memcache"
  zone_id = data.alicloud_kvstore_zones.default.zones.0.id
}

data "alicloud_cms_alarm_contact_groups" "default" {
}

module "vpc" {
  source             = "alibaba/vpc/alicloud"
  create             = true
  vpc_cidr           = "172.16.0.0/16"
  vswitch_cidrs      = ["172.16.0.0/21"]
  availability_zones = [data.alicloud_kvstore_zones.default.zones.0.id]
}

module "memcache_example" {
  source = "../.."

  #alicloud_kvstore_instance
  create_instance = true

  instance_name        = var.instance_name
  instance_class       = data.alicloud_kvstore_instance_classes.default.instance_classes.0
  vswitch_id           = module.vpc.this_vswitch_ids[0]
  availability_zone    = data.alicloud_kvstore_zones.default.zones.0.id
  security_ips         = var.security_ips
  instance_charge_type = var.instance_charge_type
  period               = var.period
  auto_renew           = var.auto_renew
  auto_renew_period    = var.auto_renew_period
  private_ip           = "172.16.0.10"
  maintain_start_time  = var.maintain_start_time
  maintain_end_time    = var.maintain_end_time
  tags                 = var.tags

  #alicloud_kvstore_backup_policy
  backup_policy_backup_period = var.backup_policy_backup_period
  backup_policy_backup_time   = var.backup_policy_backup_time

  #alicloud_cms_alarm
  enable_alarm_rule = false

}

module "use_existing_memcache" {
  source = "../.."

  #alicloud_kvstore_instance
  create_instance = false

  #alicloud_cms_alarm
  enable_alarm_rule = var.enable_alarm_rule

  alarm_rule_name               = var.alarm_rule_name
  existing_instance_id          = module.memcache_example.this_memcache_instance_id
  alarm_rule_statistics         = var.alarm_rule_statistics
  alarm_rule_operator           = var.alarm_rule_operator
  alarm_rule_threshold          = var.alarm_rule_threshold
  alarm_rule_triggered_count    = var.alarm_rule_triggered_count
  alarm_rule_period             = var.alarm_rule_period
  alarm_rule_contact_groups     = data.alicloud_cms_alarm_contact_groups.default.names
  alarm_rule_silence_time       = var.alarm_rule_silence_time
  alarm_rule_effective_interval = var.alarm_rule_effective_interval

}