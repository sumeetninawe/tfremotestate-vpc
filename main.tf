# Create VPC
resource "aws_vpc" "sl_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name        = var.vpc_name
    Environment = terraform.workspace
  }
}

# Create public subnet
resource "aws_subnet" "public_a" {
  vpc_id     = aws_vpc.sl_vpc.id
  cidr_block = var.pub_sub_a_cidr
  tags = {
    Name = var.pub_sub_a_name
  }
}

# Create private subnet
resource "aws_subnet" "private_a" {
  vpc_id     = aws_vpc.sl_vpc.id
  cidr_block = var.pri_sub_a_cidr
  tags = {
    Name = var.pri_sub_a_name
  }
}

# Create internet gateway
resource "aws_internet_gateway" "sl_igw" {
  vpc_id   = aws_vpc.sl_vpc.id
}

# Create route table for public subnet
resource "aws_route_table" "sl_public_rt" {
  vpc_id   = aws_vpc.sl_vpc.id
}

# Create default route for public subnet to use the internet gateway
resource "aws_route" "sl_public_r" {
  route_table_id         = aws_route_table.sl_public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.sl_igw.id
}

# Associate public subnet with the public route table
resource "aws_route_table_association" "sl_pub_sub_rt" {
  subnet_id      = aws_subnet.public_a.id
  route_table_id = aws_route_table.sl_public_rt.id
}

# Create route table for private subnet
resource "aws_route_table" "sl_private_rt" {
  vpc_id   = aws_vpc.sl_vpc.id
}

# Associate private subnet with the private route table
resource "aws_route_table_association" "sl_pri_sub_rt" {
  subnet_id      = aws_subnet.private_a.id
  route_table_id = aws_route_table.sl_private_rt.id
}

# Create security group for public instances
resource "aws_security_group" "public" {
  name_prefix = var.sl_pub_sg_prefix
  vpc_id      = aws_vpc.sl_vpc.id

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.sl_pub_sg_name
  }
}

# Create security group for private instances
resource "aws_security_group" "private" {
  name_prefix = var.sl_pri_sg_prefix
  vpc_id      = aws_vpc.sl_vpc.id

  ingress {
    from_port       = 0
    to_port         = 65535
    protocol        = "tcp"
    security_groups = [aws_security_group.public.id]
  }

  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.sl_pri_sg_name
  }
}
