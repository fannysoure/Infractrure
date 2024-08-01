####Create Application Load Balancer

resource "aws_lb" "external-elb" {
    name = "External-LB"
    internal = false
    load_balancer_type = "application"
    security_groups = [aws_security_group.public_sg.id]
    subnets = [aws_subnet.public_subnet[0].id, aws_subnet.public_subnet[1].id, aws_subnet.public_subnet[2].id]

  
}

resource "aws_lb_target_group" "external-elb" {
    name = "ALB-TG"
    port = 80
    protocol = "HTTP"
    vpc_id = aws_vpc.myvpc.id

    tags = {
      Name = "ALB-TG"
    }
  
}

resource "aws_lb_target_group_attachement" "external-elb" {
    count = var.items_count
    target_group_arn = aws_lb_target_group.external-elb.arn
    target_id = aws_instance.server[count.index].id
    port = 80

    depends_on = [ 
        aws_instance.server [1] 
        ]
  
}

resource "aws_lb_listener" "external-elb" {
    load_balancer_arn = aws_lb.external-elb.arn
    port = "80"
    protocol = "HTTP"

    default_action {
      type = "forward"
      target_group_arn = aws_lb_target_group.external-elb.arn
    }
  
}
