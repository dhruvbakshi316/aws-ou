# AWS Organizations OU Module

A Terraform module for creating and managing AWS Organizations Organizational Units (OUs) with support for nested hierarchies and flexible tagging.

## Features

- Create single or multiple OUs
- Support for nested OU hierarchies (up to 5 levels)
- Flexible tagging system
- Multiple deployment patterns supported

## Prerequisites

- AWS account with Organizations enabled
- Terraform 1.0+
- AWS provider configured
- Appropriate IAM permissions

## Usage

### 1. Basic OU Creation
```hcl
module "simple_ou" {
  source    = "/path/to/module"
  ou_name   = "my-ou"
  parent_id = data.aws_organizations_organization.org.roots[0].id
  tags = {
    managed_by = "terraform"
  }
}
```

### 2. Creating Nested OUs
```hcl
module "parent_ou" {
  source    = "/path/to/module"
  ou_name   = "parent-ou"
  parent_id = data.aws_organizations_organization.org.roots[0].id
}

module "child_ou" {
  source    = "/path/to/module"
  ou_name   = "child-ou"
  parent_id = module.parent_ou.ou_id
  depends_on = [module.parent_ou]
}
```

### 3. Using For-Each to Create Multiple OUs
```hcl
locals {
  sub_ous = {
    frontend = { name = "frontend", tags = { component = "frontend" } }
    backend  = { name = "backend", tags = { component = "backend" } }
  }
}

module "component_ous" {
  for_each  = local.sub_ous
  source    = "/path/to/module"
  ou_name   = each.value.name
  parent_id = module.parent_ou.ou_id
  tags      = each.value.tags
}
```

## Module Structure
```
.
├── main.tf          # Main OU resource configuration
├── variables.tf     # Input variables
├── outputs.tf       # Output definitions
└── README.md       # This file
```

## Input Variables

| Name | Description | Type | Required | Default |
|------|-------------|------|----------|---------|
| ou_name | Name of the Organizational Unit | string | yes | - |
| parent_id | ID of parent OU or organization root | string | yes | - |
| tags | Tags to apply to the OU | map(string) | no | {} |

## Outputs

| Name | Description |
|------|-------------|
| ou_id | The ID of the created OU |
| ou_arn | The ARN of the created OU |

## Example Use Cases

1. **Simple Organization Structure**
   - Single level of OUs
   - Basic tagging

2. **Multi-Level Hierarchy**
   - Parent/child relationship
   - Deep nesting (up to 5 levels)

3. **Component-Based Structure**
   - Multiple OUs at same level
   - Consistent tagging across components

4. **Environment Segregation**
   - Separate OUs for dev/prod
   - Environment-specific tagging

## Best Practices

1. Always specify meaningful tags
2. Use explicit dependencies with depends_on
3. Follow AWS Organizations naming conventions
4. Maintain consistent tagging strategy
5. Document OU hierarchy changes
