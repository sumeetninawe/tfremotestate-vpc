variable "vpc_cidr" {
  type      = string
  sensitive = true
}

variable "vpc_name" {
  type = string
}

variable "pub_sub_a_cidr" {
  type = string
}

variable "pri_sub_b_cidr" {
  type = string
}

variable "pub_sub_a_name" {
  type = string
}

variable "pri_sub_a_cidr" {
  type = string
}

variable "pri_sub_a_name" {
  type = string
}

variable "pri_sub_b_name" {
  type = string
}

variable "sl_pub_sg_prefix" {
  type = string
}

variable "sl_pub_sg_name" {
  type = string
}

variable "sl_pri_sg_prefix" {
  type = string
}

variable "sl_pri_sg_name" {
  type = string
}

output "vpc_id" {
  value = aws_vpc.sl_vpc.id
}

output "vpc_cidr" {
  value     = aws_vpc.sl_vpc.cidr_block
  sensitive = true
}

output "subnets" {
  value = [aws_subnet.public_a.id, aws_subnet.private_a.id]
}

output "subnet_pub_id" {
  value = aws_subnet.public_a.id
}

output "subnet_pri_id" {
  value = aws_subnet.private_a.id
}

output "subnet_pub_name" {
  value = var.pub_sub_a_name
}

output "subnet_pri_name" {
  value = var.pri_sub_a_name
}

output "my_sg" {
  value = aws_security_group.public.id
}