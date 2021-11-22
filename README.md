Terraform module which creates Memcache database on Alibaba Cloud.  
terraform-alicloud-memcache

English | [简体中文](https://github.com/terraform-alicloud-modules/terraform-alicloud-memcache/blob/master/README-CN.md)

Terraform module which creates Memcache and other resources on Alibaba Cloud.

These types of resources are supported:

* [alicloud_kvstore_instance](https://www.terraform.io/docs/providers/alicloud/r/kvstore_instances.html)
* [alicloud_kvstore_backup_policy](https://www.terraform.io/docs/providers/alicloud/r/kvstore_backup_policy.html)
* [alicloud_kvstore_account](https://www.terraform.io/docs/providers/alicloud/r/kvstore_account.html)
* [Alicloud_cms_alarm](https://www.terraform.io/docs/providers/alicloud/r/cms_alarm.html)

Usage
-----
    
For new instance
    
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

For existing instance 

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

## Examples

* [complete](https://github.com/terraform-alicloud-modules/terraform-alicloud-memcache/tree/master/examples/complete)
* [using-existing-memcache-instance](https://github.com/terraform-alicloud-modules/terraform-alicloud-memcache/tree/master/examples/using-existing-memcache-instance)

## Notes
From the version v1.1.0, the module has removed the following `provider` setting:

```hcl
provider "alicloud" {
  profile                 = var.profile != "" ? var.profile : null
  shared_credentials_file = var.shared_credentials_file != "" ? var.shared_credentials_file : null
  region                  = var.region != "" ? var.region : null
  skip_region_validation  = var.skip_region_validation
  configuration_source    = "terraform-alicloud-modules/memcache"
}
```

If you still want to use the `provider` setting to apply this module, you can specify a supported version, like 1.0.0:

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

If you want to upgrade the module to 1.1.0 or higher in-place, you can define a provider which same region with
previous region:

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
or specify an alias provider with a defined region to the module using `providers`:

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

and then run `terraform init` and `terraform apply` to make the defined provider effect to the existing module state.

More details see [How to use provider in the module](https://www.terraform.io/docs/language/modules/develop/providers.html#passing-providers-explicitly)

## Terraform versions

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12.0 |
| <a name="requirement_alicloud"></a> [alicloud](#requirement\_alicloud) | >= 1.68.0 |


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

