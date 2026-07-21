resource "aws_vpc" "production_vpc" {
  cidr_block = "10.0.0.0/16"

  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "production_vpc"
  }

}
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.production_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "production-public-subnet"

  }

}
resource "aws_internet_gateway" "Production_igw" {
  vpc_id = aws_vpc.production_vpc.id

  tags = {
    Name = "Production-internet-gateway"
  }

}
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.production_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.Production_igw.id
  }
  tags = {
    Name = "production-public-route-table"
  }

}
resource "aws_route_table_association" "public_subnet_association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_route_table.id


}
resource "aws_security_group" "web_sg" {
  name        = "production-web-sg"
  description = "security group for web server"
  vpc_id      = aws_vpc.production_vpc.id


  ingress {
    description = "ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "http"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }



}

resource "aws_instance" "production_server" {
  ami                    = "ami-01a00762f46d584a1"
  instance_type          = "t2.micro"
  key_name               = "web1"
  subnet_id              = aws_subnet.public_subnet.id
  vpc_security_group_ids = [aws_security_group.web_sg.id]

  tags = {
    Name = "Poduction-server"
  }

}

