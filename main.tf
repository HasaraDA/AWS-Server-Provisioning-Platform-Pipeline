provider "aws" {
  region = "ap-southeast-1"
}

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

resource "aws_instance" "ec2_instance" {
  for_each = { for server in var.servers : server.name => server }

  ami                    = each.value.ami_id
  instance_type          = each.value.instance_type
  key_name               = each.value.key_name
  security_group_ids     = [each.value.security_group_id]
  subnet_id              = each.value.subnet_id

  tags = {
    Name = each.value.name
  }
}

output "instance_ips" {
  value = { for name, instance in aws_instance.ec2_instance : name => instance.public_ip }
}
