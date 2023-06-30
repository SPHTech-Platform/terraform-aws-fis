variable "create_service_linked_role" {
  description = "Whether to create a Service-Linked Role for FIS"
  type        = bool
  default     = true
}

variable "create_fis_role" {
  description = "Whether to create FIS role to run experiments"
  type        = bool
  default     = true
}

variable "fis_role_name" {
  description = "Name of the FIS role"
  type        = string
  default     = "fis-experiment"
}

variable "fis_policies" {
  description = "Types of policies to attach to the FIS role"
  type = object({
    ec2     = optional(bool, false)
    ecs     = optional(bool, false)
    eks     = optional(bool, false)
    network = optional(bool, false)
    rds     = optional(bool, false)
    ssm     = optional(bool, false)
  })
  default = {}
}

variable "experiment_name" {
  description = "Name of FIS experiment"
  type        = string
  default     = "experiment"
}

variable "experiment_description" {
  description = "Description of the FIS experiment"
  type        = string
  default     = "An experiment"
}

variable "actions" {
  description = "List of actions to take"
  type = list(object({
    name      = string
    action_id = string

    description = optional(string)
    parameter   = optional(map(string), {})
    start_after = optional(list(string))
    target = optional(object({
      key   = string
      value = string
    }), null)
  }))
}

variable "stop_conditions" {
  description = "List of stop conditions"
  type = list(object({
    source = string
    value  = optional(string)
  }))
}

variable "targets" {
  description = "List of targets"
  type = list(object({
    name           = string
    resource_type  = string
    selection_mode = string

    filter = optional(list(object({
      path   = string
      values = list(string)
    })), [])

    resource_arns = optional(list(string))

    resource_tags = optional(list(object({
      key   = string
      value = string
    })), [])
  }))
}

variable "log_schema_version" {
  description = "Log schema version"
  type        = number
  default     = 2
}

variable "cloudwatch_logging" {
  description = "Configure cloudwatch logging"
  type = object({
    enabled = optional(bool, false)

    log_group                   = optional(string)     # name of log group
    log_group_create            = optional(bool, true) # create log group
    log_group_retention_in_days = optional(number, 30) #  Specifies the number of days you want to retain log events in the specified log group. Possible values are: 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1096, 1827, 2192, 2557, 2922, 3288, 3653, and 0. If you select 0, the events in the log group are always retained and never expire.
    log_group_kms_key_id        = optional(string, null)
  })

  default = {
    enabled = false
  }
}
