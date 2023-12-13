provider "aws" {
  region = "us-east-1" # Change this to your desired AWS region
}

resource "aws_vpc" "vpc_created_by_terraform" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "vpc_created_by_terraform"
  }
}

resource "aws_subnet" "public-subnets-created_by_terraform" {
  vpc_id                  = aws_vpc.vpc_created_by_terraform.id
  for_each                = toset(var.availability_zones)
  cidr_block              = var.public_subnet_cidr_blocks[each.value]
  availability_zone       = "${var.region}${each.value}"
  map_public_ip_on_launch = true


  tags = {
    Name = "${var.name}-public-subnet-${upper(each.value)}"
  }
}

resource "aws_subnet" "private-subnets-created_by_terraform" {
  vpc_id                  = aws_vpc.vpc_created_by_terraform.id
  for_each                = toset(var.availability_zones)
  cidr_block              = var.private_subnet_cidr_blocks[each.value]
  availability_zone       = "${var.region}${each.value}"
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.name}-private-subnet-${upper(each.value)}"
  }
}

resource "aws_internet_gateway" "IGW_created_by_terraform" {

  vpc_id = aws_vpc.vpc_created_by_terraform.id
  tags = {
    Name : "${var.name}-igw"
  }
}

resource "aws_default_route_table" "main-rtb" {

  default_route_table_id = aws_vpc.vpc_created_by_terraform.default_route_table_id


  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IGW_created_by_terraform.id
  }
  tags = {
    Name : "${var.name}-Public-rtb"
  }
}

resource "aws_route_table_association" "public_subnet_association" {
  for_each = aws_subnet.public-subnets-created_by_terraform

  subnet_id      = each.value.id
  route_table_id = aws_default_route_table.main-rtb.id
}

resource "aws_route_table" "Private-rtb" {
  vpc_id = aws_vpc.vpc_created_by_terraform.id

  tags = {
    Name = "${var.name}-Private-rtb"
  }
}
resource "aws_route_table_association" "private_subnet_association" {
  for_each = aws_subnet.private-subnets-created_by_terraform

  subnet_id      = each.value.id
  route_table_id = aws_route_table.Private-rtb.id
}

resource "aws_vpc_endpoint" "s3" {
  vpc_id          = aws_vpc.vpc_created_by_terraform.id
  service_name    = "com.amazonaws.us-east-1.s3"
  route_table_ids = [aws_route_table.Private-rtb.id]

  tags = {
    Environment = "Endpoint_for_s3_gateway"
    Name        = "Endpoint_created_by_terraform"
  }

}

# resource "aws_eip" "nat_eip" {
#   for_each = aws_subnet.public-subnets-created_by_terraform
#   vpc      = true

#   tags = {
#     Name = "EIP-for-${each.key}"
#   }
# }


# resource "aws_nat_gateway" "Nat_gw" {
#   for_each      = aws_subnet.public-subnets-created_by_terraform

#   allocation_id = aws_eip.nat_eip[each.key].id
#   subnet_id     = each.value.id
#   depends_on    = [aws_internet_gateway.IGW_created_by_terraform]

#   tags = {
#     Name = "NAT-GW-for-${each.key}-EIP-${aws_eip.nat_eip[each.key].id}"
#   }
# }


# resource "aws_instance" "bastion_host" {
#   ami           = data.aws_ami.ubuntu.id
#   instance_type = "t2.micro"
#   key_name = var.key_pair
#   vpc_security_group_ids = [aws_security_group.aws_bastion_host_sec_grp.id]
#   subnet_id = aws_subnet.aws_capstone_vpc_public_subnet_A.id

#   tags = {
#     Name = "aws_capstone_bastion_host"
#   }
# }