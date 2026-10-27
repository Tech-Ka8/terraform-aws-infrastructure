provider "aws" {
    region  = "af-south-1"
}




#Create Vpc

resource "aws_vpc" "prod-vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "Production"

  }
}


#Create internet gateway

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.prod-vpc.id

}

#Create Custom route Table
resource "aws_route_table" "prod-route-table" {
  vpc_id = aws_vpc.prod-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "Prod"
  }
}
#Create a subnet

resource "aws_subnet" "subnet-1"  {
  vpc_id = aws_vpc.prod-vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "af-south-1a"

  tags = {
    Name = "Prod-subnet"
  }
}
#Associate subnet with Route Table

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.subnet-1.id
  route_table_id = aws_route_table.prod-route-table.id
}

#Create security group to allow port 22,80,443

resource "aws_security_group" "allow_tls" {
  name        = "allow_web-traffic"
  description = "Allow web inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.prod-vpc.id


}

resource "aws_vpc_security_group_ingress_rule" "allow_http_ipv4" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = "105.127.9.35/32"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = aws_vpc.prod-vpc.cidr_block
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}


resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

#Create a network interface with an ip in the subnet that was created in step 4

resource "aws_network_interface" "web-server-nic" {
  subnet_id       = aws_subnet.subnet-1.id
  private_ips     = ["10.0.1.50"]
  security_groups = [aws_security_group.allow_tls.id]


}

#Assign an elastic IP to the network interface created in step 7

resource "aws_eip" "one" {
  domain                    = "vpc"
  network_interface         = aws_network_interface.web-server-nic.id
  associate_with_private_ip = "10.0.1.50"
  depends_on = [aws_internet_gateway.gw]
}
#Create Ubuntu server and install/enable Apache2

resource "aws_instance" "web-server-instance" {
  ami = "ami-0001c7ebca57748bf"
  instance_type = "t3.micro"
  availability_zone = "af-south-1a"
  key_name = "Admin-key"


 primary_network_interface {
    network_interface_id = aws_network_interface.web-server-nic.id
  }

user_data = <<-EOF
  #!/bin/bash
  apt update -y
  apt install apache2 -y
  systemctl start apache2
  echo "Your very first web server" > /var/www/html/index.html
EOF

    tags = {
      Name = "web-server"
    }
}
