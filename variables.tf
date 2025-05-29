# modules/aws-ou/variables.tf
variable "ou_name" {
  description = "Name of the Organizational Unit"
  type        = string
}

variable "parent_id" {
  description = "ID of the parent (either root or another OU)"
  type        = string
}

variable "tags" {
  description = "Tags to apply to the OU"
  type        = map(string)
  default     = {}
}

variable "nested_ous" {
  description = "Map of nested OUs to create under this OU"
  type = map(object({
    name = string
    tags = optional(map(string), {})
  }))
  default = {}
}
