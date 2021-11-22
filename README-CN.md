 terraform-alicloud-memcache
=====================================================================


本 Module 用于在阿里云的 VPC 下创建一个[memcache云数据库](https://help.aliyun.com/product/26528.html)。

本 Module 支持创建以下资源:

* [Memcache 数据库实例 (memcache_instance)](https://www.terraform.io/docs/providers/alicloud/r/kvstore_instances.html)
* [Memcache 数据库实例的备份策略 (memcache_backup_policy)](https://www.terraform.io/docs/providers/alicloud/r/kvstore_backup_policy.html)
* [Memcache 数据库的账号 (memcache_account)](https://www.terraform.io/docs/providers/alicloud/r/kvstore_account.html)
* [CmsAlarm 云监控实例 (cms_alarm)](https://www.terraform.io/docs/providers/alicloud/r/cms_alarm.html)

## 用法

#### 创建新的Memcache实例

```hcl
module "memcache" {
  source               = "terraform-alicloud-modules/memcache/alicloud"
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

### 使用已经存在的Memcache实例

```hcl
module "memcache" {
  source               = "terraform-alicloud-modules/memcache/alicloud"
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

## 示例

* [创建 Memcache 完整示例](https://github.com/terraform-alicloud-modules/terraform-alicloud-memcache/tree/master/examples/complete)
* [使用已经存在的 Memcache 实例创建示例](https://github.com/terraform-alicloud-modules/terraform-alicloud-memcache/tree/master/examples/using-existing-memcache-instance)

## 注意事项


作者
-------
Created and maintained by Yi Jincheng(yi785301535@163.com), He Guimin(@xiaozhu36, heguimin36@163.com)

许可
----
Apache 2 Licensed. See LICENSE for full details.

参考
---------
* [Terraform-Provider-Alicloud Github](https://github.com/terraform-providers/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://www.terraform.io/docs/providers/alicloud/index.html)


