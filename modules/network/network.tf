resource "aws_vpc" "asg_lab" {
  cidr_block = var.vpc_cidr_block

  tags = {
    Name = "vpc-asg-lab"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.asg_lab.id

  tags = {
    Name = "igw-asg-lab"
  }
}

resource "aws_subnet" "asg_lab" {
  vpc_id                  = aws_vpc.asg_lab.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "subnet-asg-lab"
  }
}

resource "aws_route_table" "asg_lab" {
  vpc_id = aws_vpc.asg_lab.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "rt-asg-lab"
  }
}

resource "aws_route_table_association" "asg_lab" {
  subnet_id      = aws_subnet.asg_lab.id
  route_table_id = aws_route_table.asg_lab.id
}
