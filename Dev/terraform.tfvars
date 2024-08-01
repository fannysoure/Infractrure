aws_region = "us-west-2"
environment = "dev"
instance_type = var.instance_type
subnet_ids     = aws_subnet.public_subnet[count.index].id
desired_capacity = 2
