locals {
  fis_iam_role_arn = var.create_fis_role ? module.fis_role.iam_role_arn : data.aws_iam_role.fis[0].arn
}

resource "aws_fis_experiment_template" "this" {
  description = var.experiment_description
  role_arn    = local.fis_iam_role_arn

  tags = {
    Name = var.experiment_name
  }

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
          key   = parameter.key
          value = parameter.value
        }
      }

      dynamic "target" {
        for_each = action.value.target[*]

        content {
          key   = target.value.key
          value = target.value.value
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

  dynamic "log_configuration" {
    for_each = var.cloudwatch_logging.enabled ? [{}] : []

    content {
      log_schema_version = var.log_schema_version

      dynamic "cloudwatch_logs_configuration" {
        for_each = var.cloudwatch_logging.enabled ? [{}] : []

        content {
          log_group_arn = var.cloudwatch_logging.log_group_create ? "${aws_cloudwatch_log_group.this[0].arn}:*" : "${data.aws_cloudwatch_log_group.this[0].arn}:*"
        }
      }
    }
  }
}
