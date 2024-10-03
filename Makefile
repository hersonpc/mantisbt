build:
	@docker build -t hersonpc/mantisbt:latest .

push:
	@docker push hersonpc/mantisbt:latest