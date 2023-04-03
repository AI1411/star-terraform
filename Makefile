.PHONY: tf-init
tf-init:
	docker-compose run --rm terraform init
tf-plan:
	docker-compose run --rm terraform plan
tf-apply:
	docker-compose run --rm terraform apply
tf-destroy:
	docker-compose run --rm terraform destroy