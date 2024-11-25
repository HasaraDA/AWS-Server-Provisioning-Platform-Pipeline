provider "aws" {
  region = "ap-southeast-1"
}

resource "aws_instance" "ec2_instance" {
  for_each = { for server in var.servers : server.name => server }

  ami                         = each.value.ami_id
  instance_type               = each.value.instance_type
  key_name                    = each.value.key_name
  security_groups             = [each.value.security_group_id]
  subnet_id                   = each.value.subnet_id
  associate_public_ip_address = each.value.assign_public_ip

  tags = {
    Name = each.value.name
  }

  lifecycle {
    prevent_destroy = true
    ignore_changes = [
      ami,
      instance_type,
      key_name,
      security_groups,
      subnet_id
    ]
  }
}

output "instance_ips" {
  value = { for name, instance in aws_instance.ec2_instance : name => instance.public_ip }
}
