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
  count = var.cloudwatch_logging.enabled && var.cloudwatch_logging.log_group_create && var.create_fis_role ? 1 : 0

  statement {
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:PutLogEventsBatch",
    ]

    resources = ["${aws_cloudwatch_log_group.this[0].arn}:*"]
  }
}

resource "aws_iam_role_policy" "cloudwatch_logging" {
  count = var.cloudwatch_logging.enabled && var.cloudwatch_logging.log_group_create && var.create_fis_role ? 1 : 0

  name_prefix = "fis-cloudwatch-logs"
  role        = module.fis_role.iam_role_name
  policy      = data.aws_iam_policy_document.fis_cloudwatch_logs[0].json
}
