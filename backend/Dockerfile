# Imagen base
FROM node:20-slim

# Crear directorio de trabajo
WORKDIR /app

# Copiar solo lo necesario para instalar dependencias
COPY package.json ./

# Instalar dependencias en modo producción
RUN npm install --omit=dev

# Copiar solo el código fuente
COPY src ./src

# Exponer el puerto usado por la app
EXPOSE 3000

# Comando de inicio
CMD ["npm","start"]
