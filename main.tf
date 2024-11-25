provider "aws" {
  region = "us-east-1"
}

variable "servers" {
  description = "List of server configurations"
  type        = list(object({
    name              = string
    instance_type     = string
    ami_id            = string
    security_groups   = list(string)
    key_name          = string
  }))
}

resource "aws_instance" "ec2_instance" {
  for_each = { for idx, server in var.servers : server.name => server }

  ami                    = each.value.ami_id
  instance_type          = each.value.instance_type
  key_name               = each.value.key_name
  security_group_ids     = each.value.security_groups
  tags = {
    Name = each.value.name
  }
}

output "instance_ips" {
  value = aws_instance.ec2_instance[*].public_ip
}
