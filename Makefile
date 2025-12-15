.PHONY: fmt validate plan apply ansible-lint test

fmt:
	test -f requirements.txt || true
	terraform -version || true

validate:
	terraform -chdir=terraform/aws init -upgrade || true
	terraform -chdir=terraform/aws validate || true

plan:
	terraform -chdir=terraform/aws plan

apply:
	terraform -chdir=terraform/aws apply

ansible-lint:
	ansible-lint ansible/ || true

test:
	python -m pytest -q

setup-terraform:
	powershell -ExecutionPolicy Bypass -File scripts\install-terraform.ps1 -Version latest
