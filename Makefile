down:
	docker compose down --remove-orphans

destroy:
	docker compose down --remove-orphans --volumes

up: down
	docker compose up -d --build
	docker compose ps
	$(MAKE) logs
	$(MAKE) sh

logs:
	docker compose logs app

sh:
	docker compose exec -it app sh

ssh: 
	ssh alyzee@51.91.208.111