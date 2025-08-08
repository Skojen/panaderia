# Nombre del servicio en docker-compose
SERVICE=frontend

# Puerto local de la app
PORT=8080

.PHONY: up build stop down logs shell clean open restart

# Build + run
up:
	docker compose up --build -d
	@echo "La app está corriendo en http://localhost:$(PORT)"

# Solo build
build:
	docker compose build

# Stop contenedores
stop:
	docker compose stop

# Elimina contenedores, sin eliminar imágenes
down:
	docker compose down

# Logs en tiempo real
logs:
	docker compose logs -f $(SERVICE)

# Acceso al contenedor
shell:
	docker exec -it $(SERVICE) sh

# Limpia contenedores, volúmenes y redes
clean:
	docker compose down -v --remove-orphans

# Abre el navegador
open:
	xdg-open http://localhost:$(PORT) || open http://localhost:$(PORT) || echo "Abre http://localhost:$(PORT) manualmente"

# Reinicia el contenedor
restart:
	docker compose restart $(SERVICE)