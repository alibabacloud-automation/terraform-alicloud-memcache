# 下线公告

感谢您对阿里云 Terraform Module 的关注。 由于 [OCS（旧版Memcache）产品已退市](https://help.aliyun.com/zh/memcache/product-overview/notice-ocs-eol-announcement)，即日起，本 Module 将停止维护并会在将来正式下线。推荐您使用 [terraform-alicloud-redis](https://registry.terraform.io/modules/terraform-alicloud-modules/redis/alicloud) 作为替代方案。更多丰富的 Module 可在 [阿里云 Terraform Module](https://registry.terraform.io/browse/modules?provider=alibaba) 中搜索获取。

再次感谢您的理解和合作。

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
本Module从版本v1.1.0开始已经移除掉如下的 provider 的显式设置：

```hcl
provider "alicloud" {
  profile                 = var.profile != "" ? var.profile : null
  shared_credentials_file = var.shared_credentials_file != "" ? var.shared_credentials_file : null
  region                  = var.region != "" ? var.region : null
  skip_region_validation  = var.skip_region_validation
  configuration_source    = "terraform-alicloud-modules/memcache"
}
```

如果你依然想在Module中使用这个 provider 配置，你可以在调用Module的时候，指定一个特定的版本，比如 1.0.0:

```hcl
module "memcache" {
  source         = "terraform-alicloud-modules/memcache/alicloud"
  version        = "1.0.0"
  region         = "cn-shanghai"
  profile        = "Your-Profile-Name"
  instance_class = "memcache.master.mid.default"
  period         = 1
  // ...
}
```

如果你想对正在使用中的Module升级到 1.1.0 或者更高的版本，那么你可以在模板中显式定义一个相同Region的provider：
```hcl
provider "alicloud" {
  region  = "cn-shanghai"
  profile = "Your-Profile-Name"
}
module "memcache" {
  source         = "terraform-alicloud-modules/memcache/alicloud"
  instance_class = "memcache.master.mid.default"
  period         = 1
  // ...
}
```
或者，如果你是多Region部署，你可以利用 `alias` 定义多个 provider，并在Module中显式指定这个provider：

```hcl
provider "alicloud" {
  region  = "cn-shanghai"
  profile = "Your-Profile-Name"
  alias   = "sh"
}
module "memcache" {
  source         = "terraform-alicloud-modules/memcache/alicloud"
  providers      = {
    alicloud = alicloud.sh
  }
  instance_class = "memcache.master.mid.default"
  period         = 1
  // ...
}
```

定义完provider之后，运行命令 `terraform init` 和 `terraform apply` 来让这个provider生效即可。

更多provider的使用细节，请移步[How to use provider in the module](https://www.terraform.io/docs/language/modules/develop/providers.html#passing-providers-explicitly)

## Terraform 版本

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.0 |
| <a name="requirement_alicloud"></a> [alicloud](#requirement\_alicloud) | >= 1.68.0 |

作者
-------
Created and maintained by Alibaba Cloud Terraform Team(terraform@alibabacloud.com)

许可
----
Apache 2 Licensed. See LICENSE for full details.

参考
---------
* [Terraform-Provider-Alicloud Github](https://github.com/terraform-providers/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://www.terraform.io/docs/providers/alicloud/index.html)