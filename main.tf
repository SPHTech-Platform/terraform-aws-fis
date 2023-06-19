resource "aws_fis_experiment_template" "this" {
  description = var.experiment_description
  role_arn    = module.fis_role.iam_role_arn

  dynamic "stop_condition" {
    for_each = var.stop_conditions

    content {
      source = stop_condition.value.source
      value  = stop_condition.value.value
    }
  }

  dynamic "action" {
    for_each = var.actions

    content {
      name        = action.value.name
      action_id   = action.value.action_id
      description = action.value.description

      start_after = action.value.start_after

      dynamic "parameter" {
        for_each = action.value.parameter

        content {
          key   = lookup(each.value, "key")
          value = lookup(each.value, "value")
        }
      }

      dynamic "target" {
        for_each = action.value.target

        content {
          key   = lookup(each.value, "key")
          value = lookup(each.value, "value")
        }
      }
    }
  }

  dynamic "target" {
    for_each = var.targets

    content {
      name           = target.value.name
      resource_type  = target.value.resource_type
      selection_mode = target.value.selection_mode

      resource_arns = target.value.resource_arns

      dynamic "filter" {
        for_each = target.value.filter

        content {
          path   = filter.value.path
          values = filter.value.values
        }
      }

      dynamic "resource_tag" {
        for_each = target.value.resource_tags

        content {
          key   = resource_tag.value.key
          value = resource_tag.value.value
        }
      }
    }
  }
}
