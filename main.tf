provider "aws" {
  region = "ap-southeast-1"
}

# Load the JSON file containing the server configurations
locals {
  servers = jsondecode(file("config.json")).servers
}

resource "aws_instance" "ec2_instance" {
  for_each = { for server in local.servers : server.name => server }

  ami                         = each.value.ami_id
  instance_type               = each.value.instance_type
  key_name                    = each.value.key_name
  security_groups             = [each.value.security_group_id]  # Changed this line
  subnet_id                   = each.value.subnet_id
  associate_public_ip_address = each.value.assign_public_ip

  tags = {
    Name = each.value.name
  }

  # Comment out or remove prevent_destroy for this run
  lifecycle {
     prevent_destroy = true  # Temporarily disable prevent_destroy for this run
  }
}

output "instance_ips" {
  value = { for name, instance in aws_instance.ec2_instance : name => instance.public_ip }
}
