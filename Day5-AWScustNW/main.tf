# creating VPC
resource "aws_vpc" "prod" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "prod_vpc"
  }
}

# creating subnet
resource "aws_subnet" "prod" {
  vpc_id     = aws_vpc.prod.id
  cidr_block = "10.0.0.0/24"
  tags = {
    Name = "prod_subnet"
  }
}

# creating internet gateway
resource "aws_internet_gateway" "prod" {
  vpc_id = aws_vpc.prod.id
  tags = {
    Name = "prod_ig"
  }
}

# creating Route table and Edit Routes
resource "aws_route_table" "prod" {
  vpc_id = aws_vpc.prod.id
  route {
    gateway_id = aws_internet_gateway.prod.id
    cidr_block = "0.0.0.0/0"
  }
}

# subnet Association
resource "aws_route_table_association" "prod" {
  route_table_id = aws_route_table.prod.id
  subnet_id      = aws_subnet.prod.id
}

# create security group
resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.prod.id

  tags = {
    Name = "allow_tls"
  }

  ingress {
    description = "Allow TLS from VPC"
    cidr_blocks = [aws_vpc.prod.cidr_block]
    from_port   = 443
    protocol = "tcp"
    to_port     = 443
  }

  ingress {
    description = "Allow HTTP from VPC"
    cidr_blocks = [aws_vpc.prod.cidr_block]
    from_port   = 80
    protocol = "tcp"
    to_port     = 80
  }

  egress {
    cidr_blocks     = ["0.0.0.0/0"]
    from_port       = 0
    protocol     = "tcp"
    to_port         = 0
  }
}

# creation of server (EC2 instance)
resource "aws_instance" "prod" {
  ami                    = "ami-05b10e08d247fb927"
  instance_type          = "t2.micro"
  key_name               = "newkey"
  subnet_id             = aws_subnet.prod.id
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  tags = {
    Name = "prod-ec2"
  }
}
