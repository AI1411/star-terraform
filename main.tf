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

resource "aws_subnet" "star_public_subnet_2" {
  vpc_id                  = aws_vpc.star_vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "ap-northeast-1c"
  map_public_ip_on_launch = true

  tags = {
    Name = "star-public-subnet-2"
  }
}

# Private Subnets
resource "aws_subnet" "star_private_subnet_1" {
  vpc_id            = aws_vpc.star_vpc.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "ap-northeast-1a"

  tags = {
    Name = "star-private-subnet-1"
  }
}

resource "aws_subnet" "star_private_subnet_2" {
  vpc_id            = aws_vpc.star_vpc.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = "ap-northeast-1c"

  tags = {
    Name = "star-private-subnet-2"
  }
}

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

resource "aws_ecr_repository" "star_ecr" {
  name = "star"
}

output "ecr_repository_url" {
  value = aws_ecr_repository.star_ecr.repository_url
}

resource "aws_instance" "star_ec2" {
  ami           = "ami-02a2700d37baeef8b" # Amazon Linux 2 LTS AMI (HVM) in ap-northeast-1
  instance_type = "t2.micro"

  subnet_id = aws_subnet.star_public_subnet_1.id

#  key_name = "star"

  vpc_security_group_ids = [aws_security_group.star_sg.id]

  tags = {
    Name = "star-ec2"
  }

  # Disable default IMDSv1
  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }
}
