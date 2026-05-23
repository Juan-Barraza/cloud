resource "aws_vpc" "virginia_test_vpc" {
  cidr_block = var.virginia_vpc.cidr

  tags = {
    "Name" = "vpc_virginia_06-${local.sufix}"
  }
}


resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.virginia_test_vpc.id
  cidr_block              = var.subnets[0]
  map_public_ip_on_launch = true

  tags = {
    "Name" = "public_subnet_06-${local.sufix}"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.virginia_test_vpc.id
  cidr_block = var.subnets[1]

  tags = {
    "Name" = "private_subnet_06-${local.sufix}"
  }

  depends_on = [
    aws_subnet.public_subnet // depends to create first the public subnet

  ]
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.virginia_test_vpc.id

  tags = {
    Name = "igw_vpc_virginia-${local.sufix}"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.virginia_test_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }


  tags = {
    Name = "public_crt-${local.sufix}"
  }
}

resource "aws_route_table_association" "crta_public_subnet" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_security_group" "public_instance_sg" {
  name        = "SecurityGroup 06"
  description = "Allow SSH inbound traffic"
  vpc_id      = aws_vpc.virginia_test_vpc.id

  dynamic "ingress" { // dynamic block
    for_each = var.ingress_ports_list
    content {
      from_port = ingress.value
      to_port   = ingress.value
      protocol = "tcp"
      cidr_blocks = [ var.sg_ingress_cdir ]
    }
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "Allow Ssh 06-${local.sufix}"
  }

}
