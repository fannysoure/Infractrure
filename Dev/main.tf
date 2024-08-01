provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source = "../modules/vpc"
  cidr_block = "10.0.0.0/16"
  subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

module "rds" {
  source = "../modules/rds"
  allocated_storage = 20
  db_subnet_group_name = aws_db_subnet_group.rds.name
  engine = "mysql"
  instance_class = var.instance_type
  multi_az = false
  name = "mydb"
  username = "admin"
  password = "password"
  skip_final_snapshot = true
  security_group_ids = [aws_security_group.db_sg.id]
}

module "autoscaling" {
  source = "../modules/autoscaling"
  image_id = "ami-12345678"
  instance_type = var.instance_type
  min_size = 1
  max_size = 3
  desired_capacity = var.desired_capacity
  subnet_ids = var.subnet_ids
}

module "kubernetes" {
  source = "../modules/kubernetes"
}

module "load_balancer" {
  source = "../modules/load_balancer"
  security_groups = [aws_security_group.lb_sg.id]
  subnets = var.subnet_ids
}
