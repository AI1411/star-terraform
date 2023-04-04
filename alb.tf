#resource "aws_lb" "star" {
#  load_balancer_type = "application"
#  name               = "handson"
#
#  security_groups = [aws_security_group.star_sg.id]
#  subnets         = [aws_subnet.star_public_subnet_1.id]
#}
#
#resource "aws_lb_target_group" "star" {
#  name     = "star"
#
#  vpc_id = aws_vpc.star_vpc.id
#
#  port     = 80
#  protocol = "HTTP"
#  target_type = "ip"
#
#  health_check {
#    healthy_threshold   = 2
#    unhealthy_threshold = 2
#    timeout             = 3
#    interval            = 30
#    path                = "/health"
#  }
#}
#
##resource "aws_lb_listener" "star" {
##  load_balancer_arn = aws_lb.front_end.arn
##  port              = "80"
##  protocol          = "HTTP"
##
##  load_balancer_arn = aws_lb_target_group.
##
##  default_action {
##    type             = "forward"
##    target_group_arn = aws_lb_target_group.front_end.arn
##  }
##}
#
#resource "aws_lb_listener_rule" "star" {
#  listener_arn = aws_lb_listener.star.arn
#  action {
#    type = "forward"
#    target_group_arn = aws_lb_target_group.star.arn
#  }
#  condition {
#    field = "path-pattern"
#    values = ["*"]
#  }
#}