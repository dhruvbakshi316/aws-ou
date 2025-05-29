# modules/aws-ou/main.tf
resource "aws_organizations_organizational_unit" "parent" {
  name      = var.ou_name
  parent_id = var.parent_id
  tags      = var.tags
}

resource "aws_organizations_organizational_unit" "nested" {
  for_each  = var.nested_ous
  name      = each.value.name
  parent_id = aws_organizations_organizational_unit.parent.id
  tags      = each.value.tags
}
