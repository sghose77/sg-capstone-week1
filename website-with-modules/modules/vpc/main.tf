resource "aws_vpc" "sg-vpc" {
  provider   = aws
  cidr_block = var.vpc_cidr

  tags = {
    Name = "sg-week1-VPC"
    Training_week = "Week 1"
    Phase = "Capstone project"
    Solution = "website with modules"
    
  }
}

resource "aws_subnet" "sg-subnet-1" {
  vpc_id     = aws_vpc.sg-vpc.id
  cidr_block = var.subnet_a_cidr
  availability_zone = "${var.region}a"

  tags = {
    Name = "sg-week1-subnet-a"
    Training_week = "Week 1"
    Phase = "Capstone project"
    Solution = "website with modules"
  }
}

resource "aws_subnet" "sg-subnet-2" {
  vpc_id     = aws_vpc.sg-vpc.id
  cidr_block = var.subnet_b_cidr
  availability_zone = "${var.region}b"

  tags = {
    Name = "sg-week1-subnet-b"
    Training_week = "Week 1"
    Phase = "Capstone project"
    Solution = "website with modules"
  }
}

resource "aws_internet_gateway" "sg-gw" {
  vpc_id = aws_vpc.sg-vpc.id

  tags = {
    Name = "sg-week1-gw"
    Training_week = "Week 1"
    Phase = "Capstone project"
    Solution = "website with modules"
  }
}

resource "aws_default_route_table" "sg-route-table" {
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.sg-gw.id
  }
  default_route_table_id = aws_vpc.sg-vpc.default_route_table_id

  tags = {
    Name = "sg-week1-route-table"
    Training_week = "Week 1"
    Phase = "Capstone project"
    Solution = "website with modules"
  }

}

