output "fis_role_arn" {
  description = "ARN of the FIS experiment role"
  value       = var.create_fis_role ? module.fis_role.iam_role_arn : data.aws_iam_role.fis[0].arn
}
