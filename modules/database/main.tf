####Create Database RDS

resource "aws_db_instance" "rds" {
    allocated_storage = var.rds_instance.allocated_storage
    db_subnet_group_name = aws_db_subnet_group.rds.id
    engine = var.rds_instance.engine
    engine_version = var.rds_instance.engine_version
    instance_class = var.rds_instance.instance_class 
    multi_az = var.rds_instance.multi_az
    db_name = var.rds_instance.db_name
    username = var.user_information.username
    password = var.user_information.password
    skip_final_snapshot = var.rds_instance.skip_final_snapshot
    vpc_security_group_ids = [aws_security_group.databse-sg.id]
  
}

resource "aws_db_subnet_group" "rds" {
    name = "main"
    subnet_ids = [aws_subnet.private_subnet[0].id, aws_subnet.private_subnet[1].id,
    aws_subnet.private_subnet[2].id]

    tags = {
        Name = "DB Subnet group"
    }

}