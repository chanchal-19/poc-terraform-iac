data "aws_availability_zones" "available" {}

###################
####### VPC #######
###################

resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  instance_tenancy     = "default"
  tags = {
    Name        = "${var.environment}-vpc"
    Environment = var.environment
  }
}

######################
### PUBLIC SUBNETS ###
######################

resource "aws_subnet" "public" {
  count                   = length(var.public_subnet_cidr_blocks)
  vpc_id                  = aws_vpc.vpc.id
  availability_zone       = element(data.aws_availability_zones.available.names, count.index)
  cidr_block              = var.public_subnet_cidr_blocks[count.index]
  map_public_ip_on_launch = true
  tags = {
    Name              = "${var.environment}-public-subnet-${count.index + 1}"
    Availability_zone = element(data.aws_availability_zones.available.names, count.index)
    Environment       = var.environment
    Tier              = "Public"
  }
}

######################
### PRIVATE SUBNETS ##
######################

resource "aws_subnet" "private" {
  count             = length(var.private_subnet_cidr_blocks)
  vpc_id            = aws_vpc.vpc.id
  availability_zone = element(data.aws_availability_zones.available.names, count.index)
  cidr_block        = var.private_subnet_cidr_blocks[count.index]
  tags = {
    Name              = "${var.environment}-private-subnet-${count.index + 1}"
    Availability_zone = element(data.aws_availability_zones.available.names, count.index)
    Environment       = var.environment
    Tier              = "Private"
  }
}

########################
### INTERNET GATEWAY ###
########################

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name        = "${var.environment}-igw"
    Environment = var.environment
  }
}

########################
###### ELASTIC IP ######
########################

resource "aws_eip" "nat_ip" {
  vpc = true
  tags = {
    Name        = "${var.environment}-nat-eip"
    Environment = var.environment
  }
}

#########################
###### NAT GATEWAY ######
#########################

resource "aws_nat_gateway" "nat_gw" {
  depends_on    = [aws_internet_gateway.igw]
  subnet_id     = aws_subnet.public[0].id
  allocation_id = aws_eip.nat_ip.id
  tags = {
    Name        = "${var.environment}-nat"
    Environment = var.environment
  }
}

###########################
###### PUBLIC ROUTES ######
###########################

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name        = "${var.environment}-public-rtb"
    Environment = var.environment
  }
}

resource "aws_route" "public" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "public" {
  count          = length(var.public_subnet_cidr_blocks)
  route_table_id = aws_route_table.public.id
  subnet_id      = aws_subnet.public[count.index].id
}

###########################
###### PRIVATE ROUTES #####
###########################

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name        = "${var.environment}-private-rtb"
    Environment = var.environment
  }
}

resource "aws_route" "private" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_gw.id
}

resource "aws_route_table_association" "private" {
  count          = length(var.private_subnet_cidr_blocks)
  route_table_id = aws_route_table.private.id
  subnet_id      = aws_subnet.private[count.index].id
}