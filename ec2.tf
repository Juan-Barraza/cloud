# variable "instances" {
#   description = "Instances Names"      
#   type        = list(string)
#   default     = ["apache", "mysql", "jumpserver"]
# }

// USING COUNT


# resource "aws_instance" "public_instance" {
#   count                  = length(var.instances)
#   ami                    = var.ec2_spects.ami
#   instance_type          = var.ec2_spects.instances_type
#   subnet_id              = aws_subnet.public_subnet.id
#   key_name               = data.aws_key_pair.key.key_name
#   vpc_security_group_ids = [aws_security_group.public_instance_sg.id]
#   user_data              = file("user_data.sh")

#   tags = {
#     "Name" = var.instances[count.index]  // count the instances and add the name
#   }
# }


// USING FOR EACH  
// Bets to create many resources and we have more control in each resource
variable "instances" {
  description = "Instances Names"
  type        = set(string)
  default     = ["apache"]
}


resource "aws_instance" "public_instance" {
  for_each               = var.instances
  ami                    = var.ec2_spects.ami
  instance_type          = var.ec2_spects.instances_type
  subnet_id              = aws_subnet.public_subnet.id
  key_name               = data.aws_key_pair.key.key_name
  vpc_security_group_ids = [aws_security_group.public_instance_sg.id]
  user_data              = file("user_data.sh")

  tags = {
    "Name" = "${each.value}-${local.sufix}"
  }
}


resource "aws_instance" "enable_monitoring" {
  count                  = var.enable_monitoring ? 1 : 0 // conditional
  ami                    = var.ec2_spects.ami
  instance_type          = var.ec2_spects.instances_type
  subnet_id              = aws_subnet.public_subnet.id
  key_name               = data.aws_key_pair.key.key_name
  vpc_security_group_ids = [aws_security_group.public_instance_sg.id]
  user_data              = file("user_data.sh")

  tags = {
    "Name" = "Monitoreo"
  }
}
