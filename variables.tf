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
