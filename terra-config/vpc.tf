###############################################
# VPC for 3-Tier Application + EKS Cluster
###############################################

provider "aws" {
  region = "us-east-1"
}

###############################################
# VPC
###############################################
resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "three-tier-vpc"
  }
}

###############################################
# Internet Gateway
###############################################
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "three-tier-igw"
  }
}

###############################################
# Public Subnets (us-east-1a, 1b, 1c)
###############################################
resource "aws_subnet" "public" {
  count                   = 3
  vpc_id                  = aws_vpc.main.id
  cidr_block              = cidrsubnet(aws_vpc.main.cidr_block, 8, count.index)
  map_public_ip_on_launch = true
  availability_zone       = element(["us-east-1a", "us-east-1b", "us-east-1c"], count.index)

  tags = {
    Name = "three-tier-public-${count.index + 1}"
    Tier = "public"
  }
}

###############################################
# Private Subnets (us-east-1a, 1b, 1c)
###############################################
resource "aws_subnet" "private" {
  count                   = 3
  vpc_id                  = aws_vpc.main.id
  cidr_block              = cidrsubnet(aws_vpc.main.cidr_block, 8, count.index + 10)
  map_public_ip_on_launch = false
  availability_zone       = element(["us-east-1a", "us-east-1b", "us-east-1c"], count.index)

  tags = {
    Name = "three-tier-private-${count.index + 1}"
    Tier = "private"
  }
}

###############################################
# Public Route Table
###############################################
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "three-tier-public-rt"
  }
}

###############################################
# Route Table Association (Public)
###############################################
resource "aws_route_table_association" "public_assoc" {
  count          = length(aws_subnet.public)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

###############################################
# Output
###############################################
output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnets" {
  value = aws_subnet.public[*].id
}

output "private_subnets" {
  value = aws_subnet.private[*].id
}


