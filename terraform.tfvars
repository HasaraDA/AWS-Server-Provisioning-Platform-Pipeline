servers = [
  {
    name             = "server1"
    instance_type    = "t2.micro"
    ami_id           = "ami-047126e50991d067b"
    security_group_id = "sg-07d01c4aa4a3000fb"
    key_name         = "MyKeyPair"
    vpc_id           = "vpc-0e618698bbfa4ff91"
    subnet_id        = "subnet-020cb3fa62e38cb07"
    assign_public_ip = true
  },
  {
    name             = "server2"
    instance_type    = "t2.micro"
    ami_id           = "ami-047126e50991d067b"
    security_group_id = "sg-07d01c4aa4a3000fb"
    key_name         = "MyKeyPair"
    vpc_id           = "vpc-0e618698bbfa4ff91"
    subnet_id        = "subnet-020cb3fa62e38cb07"
    assign_public_ip = false
  },
  {
    name             = "server3"
    instance_type    = "t2.micro"
    ami_id           = "ami-047126e50991d067b"
    security_group_id = "sg-07d01c4aa4a3000fb"
    key_name         = "MyKeyPair"
    vpc_id           = "vpc-0e618698bbfa4ff91"
    subnet_id        = "subnet-020cb3fa62e38cb07"
    assign_public_ip = true
  },
  {
    name             = "server4"
    instance_type    = "t2.micro"
    ami_id           = "ami-047126e50991d067b"
    security_group_id = "sg-07d01c4aa4a3000fb"
    key_name         = "MyKeyPair"
    vpc_id           = "vpc-0e618698bbfa4ff91"
    subnet_id        = "subnet-020cb3fa62e38cb07"
    assign_public_ip = true
  }
]