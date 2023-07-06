resource "aws_vpc" "vpc" {
    cidr_block            = "10.0.0.0/16"
    enable_dns_hostnames  = true
    enable_dns_support    = true 
    tags                  = {
        Name = var.vpc_name
    }
}

resource "aws_internet_gateway" "igw" {
    vpc_id        = aws_vpc.vpc.id
}

resource "aws_subnet" "public_subnet" {
    vpc_id                  = aws_vpc.vpc.id
    availability_zone       = "us-east-1a"
    cidr_block              = "10.0.1.0/24"
}

resource "aws_subnet" "private_subnet" {
    vpc_id                  = aws_vpc.vpc.id
     availability_zone      = "us-east-1b"
    cidr_block              = "10.0.2.0/24"
}

resource "aws_route_table" "route_public" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "public" {
  route_table_id    = aws_route_table.route_public.id
  subnet_id         = aws_subnet.public_subnet.id
}

resource "aws_route_table" "route_private" {
  vpc_id = aws_vpc.vpc.id
}

resource "aws_route_table_association" "private" {
  route_table_id    = aws_route_table.route_private.id
  subnet_id         = aws_subnet.private_subnet.id
}

resource "aws_db_subnet_group" "subnet_group" {
  name       = "the_subnet_group"
  subnet_ids = [aws_subnet.public_subnet.id, aws_subnet.private_subnet.id]
}
