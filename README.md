# Terraform Modules Template

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.6 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.6 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_fis_role"></a> [fis\_role](#module\_fis\_role) | terraform-aws-modules/iam/aws//modules/iam-assumable-role | ~> 5.20 |

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_cloudwatch_log_resource_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_resource_policy) | resource |
| [aws_fis_experiment_template.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/fis_experiment_template) | resource |
| [aws_iam_role_policy.cloudwatch_logging_create_delivery](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_service_linked_role.fis](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_service_linked_role) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_cloudwatch_log_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/cloudwatch_log_group) | data source |
| [aws_iam_policy_document.cloudwatch_logging_create_delivery](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.fis_cloudwatch_logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_role.fis](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_role) | data source |
| [aws_partition.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/partition) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_actions"></a> [actions](#input\_actions) | List of actions to take | <pre>list(object({<br>    name      = string<br>    action_id = string<br><br>    description = optional(string)<br>    parameter   = optional(map(string), {})<br>    start_after = optional(list(string))<br>    target = optional(object({<br>      key   = string<br>      value = string<br>    }), null)<br>  }))</pre> | n/a | yes |
| <a name="input_cloudwatch_logging"></a> [cloudwatch\_logging](#input\_cloudwatch\_logging) | Configure cloudwatch logging | <pre>object({<br>    enabled = optional(bool, false)<br><br>    log_group                   = optional(string)     # name of log group<br>    log_group_create            = optional(bool, true) # create log group<br>    log_group_retention_in_days = optional(number, 30) #  Specifies the number of days you want to retain log events in the specified log group. Possible values are: 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1096, 1827, 2192, 2557, 2922, 3288, 3653, and 0. If you select 0, the events in the log group are always retained and never expire.<br>    log_group_kms_key_id        = optional(string, null)<br>  })</pre> | <pre>{<br>  "enabled": false<br>}</pre> | no |
| <a name="input_create_fis_role"></a> [create\_fis\_role](#input\_create\_fis\_role) | Whether to create FIS role to run experiments | `bool` | `true` | no |
| <a name="input_create_service_linked_role"></a> [create\_service\_linked\_role](#input\_create\_service\_linked\_role) | Whether to create a Service-Linked Role for FIS | `bool` | `true` | no |
| <a name="input_experiment_description"></a> [experiment\_description](#input\_experiment\_description) | Description of the FIS experiment | `string` | `"An experiment"` | no |
| <a name="input_experiment_name"></a> [experiment\_name](#input\_experiment\_name) | Name of FIS experiment | `string` | `"experiment"` | no |
| <a name="input_fis_policies"></a> [fis\_policies](#input\_fis\_policies) | Types of policies to attach to the FIS role | <pre>object({<br>    ec2     = optional(bool, false)<br>    ecs     = optional(bool, false)<br>    eks     = optional(bool, false)<br>    network = optional(bool, false)<br>    rds     = optional(bool, false)<br>    ssm     = optional(bool, false)<br>  })</pre> | `{}` | no |
| <a name="input_fis_role_name"></a> [fis\_role\_name](#input\_fis\_role\_name) | Name of the FIS role | `string` | `"fis-experiment"` | no |
| <a name="input_log_schema_version"></a> [log\_schema\_version](#input\_log\_schema\_version) | Log schema version | `number` | `2` | no |
| <a name="input_stop_conditions"></a> [stop\_conditions](#input\_stop\_conditions) | List of stop conditions | <pre>list(object({<br>    source = string<br>    value  = optional(string)<br>  }))</pre> | n/a | yes |
| <a name="input_targets"></a> [targets](#input\_targets) | List of targets | <pre>list(object({<br>    name           = string<br>    resource_type  = string<br>    selection_mode = string<br><br>    filter = optional(list(object({<br>      path   = string<br>      values = list(string)<br>    })), [])<br><br>    resource_arns = optional(list(string))<br><br>    resource_tags = optional(list(object({<br>      key   = string<br>      value = string<br>    })), [])<br>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_fis_role_arn"></a> [fis\_role\_arn](#output\_fis\_role\_arn) | ARN of the FIS experiment role |
<!-- END_TF_DOCS -->
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
README.md updated successfully
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
