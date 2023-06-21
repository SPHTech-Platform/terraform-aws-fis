resource "aws_iam_service_linked_role" "fis" {
  count = var.create_service_linked_role ? 1 : 0

  aws_service_name = "fis.amazonaws.com"
}

locals {
  fis_policies = {
    ec2     = "arn:aws:iam::aws:policy/service-role/AWSFaultInjectionSimulatorEC2Access"
    ecs     = "arn:aws:iam::aws:policy/service-role/AWSFaultInjectionSimulatorECSAccess"
    eks     = "arn:aws:iam::aws:policy/service-role/AWSFaultInjectionSimulatorEKSAccess"
    network = "arn:aws:iam::aws:policy/service-role/AWSFaultInjectionSimulatorNetworkAccess"
    rds     = "arn:aws:iam::aws:policy/service-role/AWSFaultInjectionSimulatorRDSAccess"
    ssm     = "arn:aws:iam::aws:policy/service-role/AWSFaultInjectionSimulatorSSMAccess"
  }
}

module "fis_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"
  version = "~> 5.20"

  create_role = var.create_fis_role

  role_name         = var.fis_role_name
  role_requires_mfa = false

  trusted_role_services = [
    "fis.amazonaws.com",
  ]

  custom_role_policy_arns = compact([
    for type, arn in local.fis_policies : var.fis_policies[type] ? arn : ""
  ])
}

data "aws_iam_role" "fis" {
  count = var.create_fis_role ? 0 : 1

  name = var.fis_role_name
}
