variable "servers" {
  description = "List of server configurations"
  type = list(object({
    name              = string
    instance_type     = string
    ami_id            = string
    security_group_id = string
    key_name          = string
    vpc_id            = string
    subnet_id         = string
  }))
}
