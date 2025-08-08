# Etapa 1: Build
FROM node:20-slim AS build

WORKDIR /app

# Copiamos solo package.json primero para aprovechar la cache
COPY package*.json ./
RUN npm install

# Ahora copiamos el resto del código
COPY . .

# Compilamos el frontend (embeddeará REACT_APP_API_URL si se usa en el código)
RUN npm run build

# Etapa 2: Servidor Nginx
FROM nginx:alpine

# Copiamos el build generado
COPY --from=build /app/dist /usr/share/nginx/html

# Usamos nuestra propia configuración de Nginx
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Script que genera el archivo env.json en tiempo de inicio
COPY inject-env.sh /docker-entrypoint.d/

# Aseguramos permisos (aunque Alpine ya debería permitirlo)
RUN chmod +x /docker-entrypoint.d/inject-env.sh

# Puerto por defecto de Nginx
EXPOSE 80

# Comando por defecto
CMD ["nginx", "-g", "daemon off;"]