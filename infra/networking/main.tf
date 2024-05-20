variable "vpc_cidr" {}
variable "vpc_name" {}
variable "cidr_public_subnet" {}
variable "availability_zone" {}
variable "cidr_private_subnet" {}

## Output definition so that other modules can utilize these values.
output "tj_vpc_id" {
  value = aws_vpc.tj_vpc.id
}

output "tj_public_subnets_id" {
  value = aws_subnet.tj_public_subnets.*.id
}

output "public_subnet_cidr_block" {
  value = aws_subnet.tj_public_subnets.*.cidr_block
}

######## Setup VPC - creating one vpc
resource "aws_vpc" "tj_vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = var.vpc_name
    Project = "terraformjenkins"
  }
}

### Setup public subnet - creating one public subnet for EC2 webserver.
resource "aws_subnet" "tj_public_subnets" {
  count             = length(var.cidr_public_subnet)
  vpc_id            = aws_vpc.tj_vpc.id
  cidr_block        = element(var.cidr_public_subnet, count.index)
  availability_zone = element(var.availability_zone, count.index)
  tags = {
    Name = "tj_public-subnet-${count.index + 1}"
    Project = "terraformjenkins"
  }
}

# Setup private subnet
resource "aws_subnet" "tj_private_subnets" {
  count             = length(var.cidr_private_subnet)
  vpc_id            = aws_vpc.tj_vpc.id
  cidr_block        = element(var.cidr_private_subnet, count.index)
  availability_zone = element(var.availability_zone, count.index)

  tags = {
    Name = "tj-private-subnet-${count.index + 1}"
    Project = "terraformjenkins"
  }
}

# Setup Internet Gateway
resource "aws_internet_gateway" "tj_public_internet_gateway" {
  vpc_id = aws_vpc.tj_vpc.id
  tags = {
    Name = "tj-igw"
    Project = "terraformjenkins"
  }
}

# Public Route Table
resource "aws_route_table" "tj_public_route_table" {
  vpc_id = aws_vpc.tj_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.tj_public_internet_gateway.id
  }
  tags = {
    Name = "tj-public-rt"
    Project = "terraformjenkins"
  }
}

# Public Route Table and Public Subnet Association
resource "aws_route_table_association" "tj_public_rt_subnet_association" {
  count          = length(aws_subnet.tj_public_subnets)
  subnet_id      = aws_subnet.tj_public_subnets[count.index].id
  route_table_id = aws_route_table.tj_public_route_table.id
}

# Private Route Table 
resource "aws_route_table" "tj_private_route_table" {
  vpc_id = aws_vpc.tj_vpc.id
  #depends_on = [aws_nat_gateway.nat_gateway]
  tags = {
    Name = "tj-private-rt"
    Project = "terraformjenkins"
  }
}

# Private Route Table and private Subnet Association
resource "aws_route_table_association" "tj_private_rt_subnet_association" {
  count          = length(aws_subnet.tj_private_subnets)
  subnet_id      = aws_subnet.tj_private_subnets[count.index].id
  route_table_id = aws_route_table.tj_private_route_table.id
}

