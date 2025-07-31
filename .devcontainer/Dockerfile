# Imagen base de desarrollo para Node.js 20
FROM mcr.microsoft.com/devcontainers/javascript-node:20

# Instala herramientas adicionales si las necesitas
RUN apt-get update && apt-get install -y \
    postgresql-client \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# Crea directorio de trabajo
WORKDIR /workspace

