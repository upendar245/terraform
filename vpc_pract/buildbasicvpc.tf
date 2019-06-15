resource "aws_vpc" "prodvpc" {
  cidr_block       = "192.168.0.0/16"
  instance_tenancy = "default"
  enable_dns_hostnames = true
   

  tags = {
    Name = "main"
  }
}
