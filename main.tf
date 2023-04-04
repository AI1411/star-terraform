provider "aws" {
  region = "ap-northeast-1"
}

resource "aws_vpc" "star_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "star"
  }
}

# Public Subnets
resource "aws_subnet" "star_public_subnet_1" {
  vpc_id                  = aws_vpc.star_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "ap-northeast-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "star-public-subnet-1"
  }
}

#resource "aws_subnet" "star_public_subnet_2" {
#  vpc_id                  = aws_vpc.star_vpc.id
#  cidr_block              = "10.0.2.0/24"
#  availability_zone       = "ap-northeast-1c"
#  map_public_ip_on_launch = true
#
#  tags = {
#    Name = "star-public-subnet-2"
#  }
#}

# Private Subnets
#resource "aws_subnet" "star_private_subnet_1" {
#  vpc_id            = aws_vpc.star_vpc.id
#  cidr_block        = "10.0.3.0/24"
#  availability_zone = "ap-northeast-1a"
#
#  tags = {
#    Name = "star-private-subnet-1"
#  }
#}
#
#resource "aws_subnet" "star_private_subnet_2" {
#  vpc_id            = aws_vpc.star_vpc.id
#  cidr_block        = "10.0.4.0/24"
#  availability_zone = "ap-northeast-1c"
#
#  tags = {
#    Name = "star-private-subnet-2"
#  }
#}

resource "aws_security_group" "star_sg" {
  name        = "star-sg"
  description = "Security group for the star application"
  vpc_id      = aws_vpc.star_vpc.id
}

resource "aws_security_group_rule" "star_sg_rule_ingress" {
  security_group_id = aws_security_group.star_sg.id

  type        = "ingress"
  from_port   = 0
  to_port     = 65535
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "star_sg_rule_egress" {
  security_group_id = aws_security_group.star_sg.id

  type        = "egress"
  from_port   = 0
  to_port     = 65535
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

#resource "aws_lb" "star_lb" {
#  name               = "star_lb"
#  internal           = false
#  load_balancer_type = "application"
#  subnets            = [aws_subnet.star_public_subnet_1.id]
#}
#
#resource "aws_lb_target_group" "star_target_group" {
#  name        = "star_target_group"
#  port        = 80
#  protocol    = "HTTP"
#  vpc_id      = aws_vpc.star_vpc.id
#  target_type = "ip"
#}
#
#resource "aws_lb_listener_rule" "star_listener_rule" {
#  listener_arn = aws_lb_listener.star_listener.arn
#
#  action {
#    type             = "forward"
#    target_group_arn = aws_lb_target_group.star_target_group.arn
#  }
#
#  condition {
#    field  = "host-header"
#    values = ["star.domain.com"]
#  }
#}
#
#resource "aws_lb_target_group_attachment" "my_target_group_attachment" {
#  target_group_arn = aws_lb_target_group.star_target_group.arn
#  target_id        = aws_ecs_service.my_service.id
#  port             = 80
#}


#resource "aws_instance" "star_ec2" {
#  ami           = "ami-02a2700d37baeef8b" # Amazon Linux 2 LTS AMI (HVM) in ap-northeast-1
#  instance_type = "t2.micro"
#
#  subnet_id = aws_subnet.star_public_subnet_1.id
#
##  key_name = "star"
#
#  vpc_security_group_ids = [aws_security_group.star_sg.id]
#
#  tags = {
#    Name = "star-ec2"
#  }
#
#  # Disable default IMDSv1
#  metadata_options {
#    http_endpoint = "enabled"
#    http_tokens   = "required"
#  }
#}
