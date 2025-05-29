# modules/aws-ou/outputs.tf
output "ou_id" {
  description = "ID of the created OU"
  value       = aws_organizations_organizational_unit.parent.id
}

output "ou_arn" {
  description = "ARN of the created OU"
  value       = aws_organizations_organizational_unit.parent.arn
}

output "nested_ou_ids" {
  description = "Map of nested OU names to their IDs"
  value       = { for k, v in aws_organizations_organizational_unit.nested : k => v.id }
}
