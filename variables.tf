variable "servers" {
  description = "List of server configurations"
  type = list(object({
    name            = string
    instance_type   = string
    ami_id          = string
    security_groups = list(string)
    key_name        = string
  }))
}
