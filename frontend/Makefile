# Nombre del servicio en docker-compose
SERVICE=frontend

# Puerto de la app local
PORT=8080

# Build + run
up:
	docker compose up --build -d

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

# Limpia contenedor, volúmenes y redes
clean:
	docker compose down -v --remove-orphans

# Abre el navegador
open:
	xdg-open http://localhost:$(PORT) || open http://localhost:$(PORT) || echo "Abre http://localhost:$(PORT) manualmente"