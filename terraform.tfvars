
virginia_vpc = {
  cidr  = "10.40.0.0/16"
  name  = "VPC_VIRGINIA"
  env   = "Dev"
  owner = "Juan Barrazaa"
}
aws_region_virginia = "us-east-1"

# public_subnet = "10.10.0.0/24"
# private_subnet = "10.10.1.0/24"
subnets = [ "10.40.0.0/24","10.40.1.0/24" ]

tags = {
  "env" = "dev"
  "owner" = "Juan Barraza"
  "IAC" = "Terrafrom"
  "IAC_Version" = "1.15.0"
  "project" = "cerberus"
  "region" = "virginia"
}

sg_ingress_cdir = "0.0.0.0/0"

ec2_spects = {
  "ami" = "ami-0236922087fa98b6e"
  "instances_type" = "t2.micro"
}

enable_monitoring = false

ingress_ports_list = [ 22, 80, 443 ] // to dynamic block