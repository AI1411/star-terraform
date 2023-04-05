resource "aws_security_group" "alb" {
  name        = "star-alb"
  description = "Allow inbound traffic from the internet"
  vpc_id      = aws_vpc.main.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "star-alb"
  }
}

resource "aws_security_group_rule" "alb_http" {
  security_group_id = aws_security_group.alb.id

  type      = "ingress"
  from_port = 80
  to_port   = 80
  protocol  = "tcp"

  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_lb" "main" {
  name               = "star-alb"
  load_balancer_type = "application"

  security_groups = [aws_security_group.alb.id]
  subnets         = [aws_subnet.public_subnet_1d.id, aws_subnet.public_subnet_1c.id, aws_subnet.public_subnet_1d.id]

  tags = {
    Name = "star-lb"
  }
}

resource "aws_lb_listener" "main" {
  port     = "80"
  protocol = "HTTP"

  load_balancer_arn = aws_lb.main.arn

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "Hello World!"
      status_code  = "200"
    }
  }
}