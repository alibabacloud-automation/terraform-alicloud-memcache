#################
# Memcache instance
#################
variable "instance_name" {
  description = "Display name of the instance, [2, 128] English or Chinese characters, must start with a letter or Chinese in size, can contain numbers, '_' or '.', '-'."
  type        = string
  default     = "tf-testacc-name"
}

variable "security_ips" {
  description = "List of IP addresses allowed to access all memcache of an instance. The list contains up to 1,000 IP addresses, separated by commas. Supported formats include 0.0.0.0/0, 10.23.12.24 (IP), and 10.23.12.24/24 (Classless Inter-Domain Routing (CIDR) mode. /24 represents the length of the prefix in an IP address. The range of the prefix length is [1,32])."
  type        = list(string)
  default     = ["127.0.0.1"]
}

variable "instance_charge_type" {
  description = "Filter the results by charge type. Valid values: PrePaid and PostPaid. Default to PostPaid."
  type        = string
  default     = "PostPaid"
}

variable "period" {
  description = "The duration that you will buy DB instance (in month). It is valid when instance_charge_type is PrePaid. Valid values: [1~9], 12, 24, 36. Default to 1."
  type        = number
  default     = 1
}

variable "auto_renew" {
  description = "Whether to renewal a DB instance automatically or not. It is valid when instance_charge_type is PrePaid. Default to false."
  type        = bool
  default     = false
}

variable "auto_renew_period" {
  description = "Auto-renewal period of an instance, in the unit of the month. It is valid when instance_charge_type is PrePaid. Valid value:[1~12], Default to 1."
  type        = number
  default     = 1
}

variable "maintain_start_time" {
  description = "The start time of the operation and maintenance time period of the instance, in the format of HH:mmZ (UTC time)."
  type        = string
  default     = "02:00Z"
}

variable "maintain_end_time" {
  description = "The end time of the operation and maintenance time period of the instance, in the format of HH:mmZ (UTC time)."
  type        = string
  default     = "03:00Z"
}

variable "tags" {
  description = "A mapping of tags to assign to the memcache instance resource."
  type        = map(string)
  default = {
    Name = "Memcache"
  }
}

#################
# Memcache backup_policy
#################
variable "backup_policy_backup_period" {
  description = "Memcache Instance backup policy backup period."
  type        = list(string)
  default     = ["Monday"]
}

variable "backup_policy_backup_time" {
  description = "Memcache instance backup policy backup time, in the format of HH:mmZ- HH:mmZ."
  type        = string
  default     = "02:00Z-03:00Z"
}

#############
# cms_alarm
#############
variable "enable_alarm_rule" {
  description = "Whether to enable alarm rule. Default to true."
  type        = bool
  default     = true
}

variable "alarm_rule_name" {
  description = "The alarm rule name."
  type        = string
  default     = "tf-testacc-alarm-rule-name"
}

variable "alarm_rule_statistics" {
  description = "Statistical method. It must be consistent with that defined for metrics. Valid values: ['Average', 'Minimum', 'Maximum']. Default to 'Average'."
  type        = string
  default     = "Average"
}

variable "alarm_rule_operator" {
  description = "Alarm comparison operator. Valid values: ['<=', '<', '>', '>=', '==', '!=']. Default to '=='."
  type        = string
  default     = ">="
}

variable "alarm_rule_threshold" {
  description = "Alarm threshold value, which must be a numeric value currently."
  type        = string
  default     = "90"
}

variable "alarm_rule_triggered_count" {
  description = "Number of consecutive times it has been detected that the values exceed the threshold. Default to 3."
  type        = number
  default     = 3
}

variable "alarm_rule_period" {
  description = "Index query cycle, which must be consistent with that defined for metrics. Default to 300, in seconds."
  type        = number
  default     = 300
}

variable "alarm_rule_silence_time" {
  description = "Notification silence period in the alarm state, in seconds. Valid value range: [300, 86400]. Default to 86400."
  type        = number
  default     = 86400
}

variable "alarm_rule_effective_interval" {
  description = "The interval of effecting alarm rule. It foramt as 'hh:mm-hh:mm', like '0:00-4:00'."
  type        = string
  default     = "0:00-2:00"
}