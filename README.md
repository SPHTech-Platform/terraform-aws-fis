# Terraform Modules Template

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_fis_role"></a> [fis\_role](#module\_fis\_role) | terraform-aws-modules/iam/aws//modules/iam-assumable-role | ~> 5.20 |

## Resources

| Name | Type |
|------|------|
| [aws_fis_experiment_template.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/fis_experiment_template) | resource |
| [aws_iam_service_linked_role.fis](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_service_linked_role) | resource |
| [aws_iam_role.fis](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_role) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_actions"></a> [actions](#input\_actions) | List of actions to take | <pre>list(object({<br>    name      = string<br>    action_id = string<br><br>    description = optional(string)<br>    parameter   = optional(map(string), {})<br>    start_after = optional(list(string))<br>    target = optional(object({<br>      key   = string<br>      value = string<br>    }), null)<br>  }))</pre> | n/a | yes |
| <a name="input_create_fis_role"></a> [create\_fis\_role](#input\_create\_fis\_role) | Whether to create FIS role to run experiments | `bool` | `true` | no |
| <a name="input_create_service_linked_role"></a> [create\_service\_linked\_role](#input\_create\_service\_linked\_role) | Whether to create a Service-Linked Role for FIS | `bool` | `true` | no |
| <a name="input_experiment_description"></a> [experiment\_description](#input\_experiment\_description) | Description of the FIS experiment | `string` | `"An experiment"` | no |
| <a name="input_fis_policies"></a> [fis\_policies](#input\_fis\_policies) | Types of policies to attach to the FIS role | <pre>object({<br>    ec2     = optional(bool, false)<br>    ecs     = optional(bool, false)<br>    eks     = optional(bool, false)<br>    network = optional(bool, false)<br>    rds     = optional(bool, false)<br>    ssm     = optional(bool, false)<br>  })</pre> | `{}` | no |
| <a name="input_fis_role_name"></a> [fis\_role\_name](#input\_fis\_role\_name) | Name of the FIS role | `string` | `"fis-experiment"` | no |
| <a name="input_stop_conditions"></a> [stop\_conditions](#input\_stop\_conditions) | List of stop conditions | <pre>list(object({<br>    source = string<br>    value  = optional(string)<br>  }))</pre> | n/a | yes |
| <a name="input_targets"></a> [targets](#input\_targets) | List of targets | <pre>list(object({<br>    name           = string<br>    resource_type  = string<br>    selection_mode = string<br><br>    filter = optional(list(object({<br>      path   = string<br>      values = list(string)<br>    })), [])<br><br>    resource_arns = optional(list(string))<br><br>    resource_tags = optional(list(object({<br>      key   = string<br>      value = string<br>    })), [])<br>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_fis_role_arn"></a> [fis\_role\_arn](#output\_fis\_role\_arn) | ARN of the FIS experiment role |
<!-- END_TF_DOCS -->
