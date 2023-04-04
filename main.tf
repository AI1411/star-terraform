provider "aws" {
  region = "ap-northeast-1"
}

resource "aws_security_group" "sg" {
  name        = "sg"
  description = "Security group for the star application"
  vpc_id      = aws_vpc.main.id
}

resource "aws_security_group_rule" "sg_rule_ingress" {
  security_group_id = aws_security_group.sg.id

  type        = "ingress"
  from_port   = 0
  to_port     = 65535
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "sg_rule_egress" {
  security_group_id = aws_security_group.sg.id

  type        = "egress"
  from_port   = 0
  to_port     = 65535
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

#resource "aws_lb" "lb" {
#  name               = "lb"
#  internal           = false
#  load_balancer_type = "application"
#  subnets            = [aws_subnet.public_subnet_1.id]
#}
#
#resource "aws_lb_target_group" "target_group" {
#  name        = "target_group"
#  port        = 80
#  protocol    = "HTTP"
#  vpc_id      = aws_vpc.main.id
#  target_type = "ip"
#}
#
#resource "aws_lb_listener_rule" "listener_rule" {
#  listener_arn = aws_lb_listener.listener.arn
#
#  action {
#    type             = "forward"
#    target_group_arn = aws_lb_target_group.target_group.arn
#  }
#
#  condition {
#    field  = "host-header"
#    values = ["star.domain.com"]
#  }
#}
#
#resource "aws_lb_target_group_attachment" "my_target_group_attachment" {
#  target_group_arn = aws_lb_target_group.target_group.arn
#  target_id        = aws_ecs_service.my_service.id
#  port             = 80
#}


#resource "aws_instance" "ec2" {
#  ami           = "ami-02a2700d37baeef8b" # Amazon Linux 2 LTS AMI (HVM) in ap-northeast-1
#  instance_type = "t2.micro"
#
#  subnet_id = aws_subnet.public_subnet_1.id
#
##  key_name = "star"
#
#  vpc_security_group_ids = [aws_security_group.sg.id]
#
#  tags = {
#    Name = "ec2"
#  }
#
#  # Disable default IMDSv1
#  metadata_options {
#    http_endpoint = "enabled"
#    http_tokens   = "required"
#  }
#}
