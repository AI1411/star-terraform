resource "aws_ecs_cluster" "star_cluster" {
  name = "star_cluster"
}

resource "aws_ecs_task_definition" "star_task_definition" {
  family                   = "star_task_definition"
  requires_compatibilities = ["FARGATE"]

  cpu = "256"
  memory = "512"

  network_mode             = "awsvpc"

  container_definitions = <<EOL
[
  {
    "name": "nginx",
    "image": "nginx:1.14",
    "portMappings": [
      {
        "containerPort": 80,
        "hostPort": 80
      }
    ]
  }
]
EOL

  #  network_configuration {
  #    security_groups = [aws_security_group.star_sg.id]
  #    subnets         = [aws_subnet.star_public_subnet_1.id]
  #  }
}