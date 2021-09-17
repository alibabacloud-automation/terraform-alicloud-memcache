Terraform module which creates Memcache database on Alibaba Cloud.  
terraform-alicloud-memcache
==================================================================================

English | [简体中文](https://github.com/terraform-alicloud-modules/terraform-alicloud-memcache/blob/master/README-CN.md)

Terraform module which creates Memcache and other resources on Alibaba Cloud.

These types of resources are supported:

* [alicloud_kvstore_instance](https://www.terraform.io/docs/providers/alicloud/r/kvstore_instances.html)
* [alicloud_kvstore_backup_policy](https://www.terraform.io/docs/providers/alicloud/r/kvstore_backup_policy.html)
* [alicloud_kvstore_account](https://www.terraform.io/docs/providers/alicloud/r/kvstore_account.html)
* [Alicloud_cms_alarm](https://www.terraform.io/docs/providers/alicloud/r/cms_alarm.html)

## Terraform versions

This module requires Terraform 0.12 and Terraform Provider Alicloud 1.68.0+.

Usage
-----
    
For new instance
    
```hcl
module "memcache" {
  source               = "terraform-alicloud-modules/memcache/alicloud"
  region               = "cn-shanghai"
  #################
  # Memcache Instance
  #################
  availability_zone    = "cn-beijing-f"
  instance_name        = "myInstance"
  instance_class       = "memcache.master.mid.default"
  period               = 1
  vswitch_id           = "vsw-bp1tili2xxxxx"
  security_ips         = ["1.1.1.1", "2.2.2.2", "3.3.3.3"]
  instance_charge_type = "PostPaid"
  tags = {
    Env      = "Private"
    Location = "Secret"
  }

  #################
  # Memcache backup_policy
  #################

  backup_policy_backup_time    = "02:00Z-03:00Z"
  backup_policy_backup_period  = ["Monday", "Wednesday", "Friday"]

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
```

For existing instance 

```hcl
module "memcache" {
  source               = "terraform-alicloud-modules/memcache/alicloud"
  region               = "cn-shanghai"
  #################
  # Memcache Instance
  #################

  existing_instance_id = "m-uf65086bbxxxxxxx"

  #################
  # Memcache backup_policy
  #################

  backup_policy_backup_time    = "02:00Z-03:00Z"
  backup_policy_backup_period  = ["Monday", "Wednesday", "Friday"]

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
```

## Examples

* [complete](https://github.com/terraform-alicloud-modules/terraform-alicloud-memcache/tree/master/examples/complete)
* [using-existing-memcache-instance](https://github.com/terraform-alicloud-modules/terraform-alicloud-memcache/tree/master/examples/using-existing-memcache-instance)

## Notes

* This module using AccessKey and SecretKey are from `profile` and `shared_credentials_file`.
If you have not set them yet, please install [aliyun-cli](https://github.com/aliyun/aliyun-cli#installation) and configure it.


Authors
---------
Created and maintained by Alibaba Cloud Terraform Team(terraform@alibabacloud.com)

License
----
Apache 2 Licensed. See LICENSE for full details.

Reference
---------
* [Terraform-Provider-Alicloud Github](https://github.com/terraform-providers/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://www.terraform.io/docs/providers/alicloud/index.html)

