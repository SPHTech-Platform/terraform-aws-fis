resource "aws_cloudwatch_log_group" "this" {
  count = var.cloudwatch_logging.enabled && var.cloudwatch_logging.log_group_create ? 1 : 0

  name = var.cloudwatch_logging.log_group

  retention_in_days = var.cloudwatch_logging.log_group_retention_in_days
  kms_key_id        = var.cloudwatch_logging.log_group_kms_key_id
}

data "aws_cloudwatch_log_group" "this" {
  count = var.cloudwatch_logging.enabled && !var.cloudwatch_logging.log_group_create ? 1 : 0

  name = var.cloudwatch_logging.log_group
}

data "aws_iam_policy_document" "fis_cloudwatch_logs" {
  count = var.cloudwatch_logging.enabled && var.cloudwatch_logging.log_group_create ? 1 : 0

  statement {
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:PutLogEventsBatch",
    ]

    resources = ["${aws_cloudwatch_log_group.this[0].arn}:*"]

    principals {
      type        = "Service"
      identifiers = ["delivery.logs.amazonaws.com"]
    }

    condition {
      test     = "StringEquals"
      variable = "aws:SourceAccount"

      values = [data.aws_caller_identity.current.account_id]
    }

    condition {
      test     = "ArnLike"
      variable = "aws:SourceArn"

      values = ["arn:${data.aws_partition.current.partition}:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:*"]
    }
  }
}

resource "aws_cloudwatch_log_resource_policy" "this" {
  count = var.cloudwatch_logging.enabled && var.cloudwatch_logging.log_group_create ? 1 : 0

  policy_name     = "${var.experiment_name}-logging"
  policy_document = data.aws_iam_policy_document.fis_cloudwatch_logs[0].json
}

data "aws_iam_policy_document" "cloudwatch_logging_create_delivery" {
  count = var.cloudwatch_logging.enabled && var.cloudwatch_logging.log_group_create && var.create_fis_role ? 1 : 0

  statement {
    actions = [
      "logs:CreateLogDelivery",
    ]

    resources = ["*"]
  }
}

resource "aws_iam_role_policy" "cloudwatch_logging_create_delivery" {
  count = var.cloudwatch_logging.enabled && var.cloudwatch_logging.log_group_create && var.create_fis_role ? 1 : 0

  name_prefix = "fis-cloudwatch-logs"
  role        = module.fis_role.iam_role_name
  policy      = data.aws_iam_policy_document.cloudwatch_logging_create_delivery[0].json
}
