
variable "virginia_vpc" {
  type = object({
    name = string
    env = string
    owner = string
    cidr = string
  })
}

variable "aws_region_virginia" {
    type = string
}

# variable "public_subnet" {
#   description = "CIDR public subnet"
#   type = string
# }

# variable "private_subnet" {
#     description = "CIDR private subnet"
#     type = string
# }

variable "subnets" {
  description = "List Subnets"
  type = list(string)
}

variable "tags" {
  description = "Tags of Project"
  type = map(string)
}

variable "sg_ingress_cdir" {
  description = "CDIR for ingress"
  type = string
}

variable "ec2_spects" {
  description = "instances paramethers"
  type = map(string)
}

variable "enable_monitoring" {
  description = "enable monitoting server deploy"
  type = bool
}

variable "ingress_ports_list" {
  type = list(number)
}

variable "access_key" {}

variable "secret_key" {
  
}