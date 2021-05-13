#VPC creation
resource "aws_vpc" "main" {
  cidr_block       = var.VPC_CIDR
  instance_tenancy = "default"

  tags = {
    Name = var.VPC_Name
  }
}

#Creating a subnet-1
resource "aws_subnet" "public1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.Subnet_CIDR1
  availability_zone       = var.availability_zone1
  map_public_ip_on_launch = true

  tags = {
    Name = var.Subnet_Name1
  }
}



#Create IWG
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = var.IGW_Name
  }
}

#Route Table creation
resource "aws_route_table" "main" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = var.RouteTable_PublicName
  }
}

#Associate the Route table with Subnet
resource "aws_route_table_association" "public-route1" {
  subnet_id      = aws_subnet.public1.id
  route_table_id = aws_route_table.main.id
}

