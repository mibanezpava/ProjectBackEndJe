# Usa una imagen base de Node.js para construir la aplicación
FROM node:18 AS build

# Establece el directorio de trabajo
WORKDIR /app

# Copia el package.json y el package-lock.json (o yarn.lock)
COPY package*.json ./

# Instala las dependencias de la aplicación
RUN npm install

# Copia todo el código fuente de la aplicación
COPY . .

# Compila la aplicación en modo producción
RUN npm run build --prod

# Usa una imagen base de Nginx para servir la aplicación
FROM nginx:alpine

# Copia los archivos construidos al directorio de Nginx
COPY --from=build /app/dist/jejames.webapp.automatizacion/browser /usr/share/nginx/html

# Expone el puerto en el que Nginx escuchará
EXPOSE 80

# Comando para ejecutar Nginx
CMD ["nginx", "-g", "daemon off;"]
