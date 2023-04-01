.PHONY: tf-init
tf-init:
	docker run --rm -v $(pwd):/app/ -w /app/ hashicorp/terraform:latest init
tf-plan:
	docker run --rm -v $(pwd):/app/ -w /app/ hashicorp/terraform:latest plan
tf-apply:
	docker run --rm -v $(pwd):/app/ -w /app/ hashicorp/terraform:latest apply