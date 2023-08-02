variable "vpc_cidr" {
  type = string
}

variable "vpc_name" {
  type = string
}

variable "pub_sub_a_cidr" {
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

output vpc_id {
    value = aws_vpc.sl_vpc.id
}