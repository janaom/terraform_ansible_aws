provider "aws" {
    region = "eu-central-1" #us west oregon: us-west-2
}
resource "aws_instance" "my_aws" {
    ami = "ami-0d527b8c289b4af7f"
    instance_type = "t2.micro"
    key_name = "terraform"
    associate_public_ip_address = true
    vpc_security_group_ids = [aws_security_group.my_ubuntu.id]

data "aws_availability_zones" "available" {}

resource "random_id" "random" {
    byte_length = 2

}
resource "aws_vpc" "my_vpc" {
    cidr_block = var.vpc_cidr
    enable_dns_hostnames = true
    enables_dns_support = true

    tags = {
       Name = "aws_task_vpc-${random_id.random.dec}"
       Owner = "Jana"
}

    lifecycle {
      create_before_destroy = true
}
}

resource "aws_internet_gateway" "my_internet_gateway" {
     vpc_id = aws_vpc.my_vpc.id  #command to check useful info:terraform state show aws_vpc.my_vpc | grep id

    tags = {
       Name = "my_igw-${random_id.random.dec}"
       Owner = "Jana"
}
}

resource "aws_route_table" "my_public_rt" {
     vpc_id = aws_vpc.my_vpc.id

     tags = {
       Name = "my-public"
       Owner = "Jana"
}
}

resource "aws_route" "default_route" {
    route_table_id = aws_route_table.my_public.rt.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_internet_gateway.id
}

resource "aws_default_route_table" "my_private_rt" {
    default_route_table_id = aws_vpc.my_vpc.default_route_table_id

    tags = {
       Name = "my_private"
       Owner = "Jana"
}
}

resource "aws_subnet" "my_public_subnet" {
    count = length(var.public_cidrs)
    vpc_id = aws_vpc.my_vpc.id
    cidr_block = var.public_cidrs[count.index]
    map_public_ip_on_launch = true
    availability_zone = data.aws.availability_zones.available.names[count.index]

    tags = {
      Name = "my-public-${count.index + 1}"
      Owner = "Jana"
}
}

resource "aws_subnet" "my_private_subnet" {
    count = length(var.private_cidrs)
    vpc_id = aws_vpc.my_vpc.id
    cidr_block = var.private_cidrs[count.index]
    map_private_ip_on_launch = false
    availability_zone = data.aws.availability_zones.available.names[count.index]

    tags = {
      Name = "my-private-${count.index + 1}"
      Owner = "Jana"
}
}
