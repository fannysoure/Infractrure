#Create a VPC

resource "aws_vpc" "myvpc" {
  cidr_block = "var.vpc_cidr"
  tags = {
    Name = "Demo VPC"
  }
  enable_dns_hostnames = "true"
  enable_dns_support = "true"
}

# Create Internet Gateway
resource "aws_internet_gateway" "myigw" {
    vpc_id = "aws_vpc.myvpc.id"
    tags = {
      name = "IGW"
    }
  
}

##Create Public Subnet
resource "aws_subnet" "public_subnet" {
    count = "var.item_count"
    vpc_id = aws_vpc.myvpc.id
   cidr_block = var.public_subnet_cidr[count.index] 
   availability_zone = var.availability_zone_names[count.index]
   map_public_ip_on_launch = true
   tags = {
    Name = "public_subnet-${count.index}"
   }
  
}

## Create  Private Subnet
resource "aws_subnet" "private_subnet" {
    count = "var.item_count"
    vpc_id = aws_vpc.myvpc.id
   cidr_block = var.private_subnet_cidr[count.index] 
   availability_zone = var.availability_zone_names[count.index]
   
   tags = {
    Name = "private_subnet-${count.index}"
   }
  
}
###Allocate an Elastic IP

resource "aws_eip" "nat" {
  count = var.enable_nat_gateway ? var.items_count : 0
  
}

###Create Nat Gateway

resource "aws_nat_gateway" "nat_gateway" {
  count = var.enable_nat_gateway ? var.items_count : 0
  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = aws_subnet.public_subnet[count.index].id

  tags = {
    Name = "NAT Gateway ${count.index}"
  }
  
  depends_on = [aws_internet_gateway.myigw]
}



### Create Route table

resource "aws_route_table" "public_routetable" {
  vpc_id = aws_vpc.myvpc.id

  route = {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.myigw.id
  }

  tags = {
    Name = "Public Route Table"
  }
}

## Create Subnet association with route table

resource "aws_route_table_association" "rt_assoc" {
    count = var.items_count
    subnet_id = aws_subnet.public_subnet[count.index].id
    route_table_id = aws_route_table.public_routetable.id
  
}

##Create EC2 Instance

resource "aws_instance" "server" {
    count = var.items_count
    ami   = var.ami_id
    instance_type = var.instance_type
    availability_zone = var.availability_zone_names[count.index]
    vpc_security_group_ids = [aws_security_group.server-sg.id]
    subnet_id = aws_subnet.public_subnet[count.index].id
    user_data = file("install_apache.sh")

    tags = {
      Name = "server${count.index}"
    }

}

###Create Security Group for public 

resource "aws_security_group" "public_sg" {
    name = "SG"
    description = "Allow HTTP inbound traffic"
    vpc_id = aws_vpc.myvpc.id

    ingress {
        description = "HTTP from VPC"
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]

    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
      Name = Public-SG
    }
  
}

### Create Security group for Database 

resource "aws_security_group" "database-sg" {
    name = "Database-SG"
    description = "Allow inbound traffic from public subnet server"
    vpc_id = aws_vpc.myvpc.id

    ingress = {
        description = "Allow traffic from public subnet server"
        from_port = 5432
        to_port = 5432
        protocol = "tcp"
        security_groups = [aws_security_group.server-sg.id] 
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]

    }
    tags = {
      Name = Database-SG
    }
  
}




  
