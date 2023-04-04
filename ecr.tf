resource "aws_ecr_repository" "star_ecr" {
  name = "star"
}

output "ecr_repository_url" {
  value = aws_ecr_repository.star_ecr.repository_url
}