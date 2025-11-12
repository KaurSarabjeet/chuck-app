# Project file related to deployment or configuration.
unit:
	pytest -q

dev:
	FLASK_APP=app/main.py flask run --host=0.0.0.0 --port=8000

up:
	docker compose up -d --build proxy app_blue

down:
	docker compose down -v

integ:
	bash integration_test.sh
